;Azan Shehzad
;22i-2068
.model small
.stack 0100h

draw_dot macro p1, p2, c ; xaxis,yaxis,color

    Mov DX,0
    MOV CX, p1
    MOV DL, p2
    MOV AL, c
    MOV AH, 0CH
    int 10h

endm

draw_life macro p1,p2,c ;life icons for player

push p1 ;2
push p2 ;2

mov bx,p1 ;2
add bx,5    ;7

    .while(p1<bx) ;2<7
        
        push bx
        mov bx,p2
        add bx,5
        push p2 

        .while(p2<bx) ;2<7
        
            Mov CX,p1
            Mov DX,p2

            Mov Al,c
            Mov AH,0CH
            int 10H

            ADD p2,1

        .endw

        pop p2
        pop bx
        ADD p1,1

    .endw

pop p2
pop p1

endm

draw_bricks_2 macro life, x1, y1, x2, y2 ; Life/Status of the Brick, x1 y1 top left_2 points, x2 y2 bottom right_2 points

    push x1
    push y1
    push x2
    push y2

    mov bx,x2

    .while(x1<bx)
        
        push bx
        mov bx,y2
        push y1
        .while(y1<bx)
        
            Mov CX,x1
            Mov DX,y1

            Mov Al,life
            Mov AH,0CH
            int 10H

            ADD y1,1

        .endw

        pop y1
        pop bx
        ADD x1,1

    .endw

.if(life==0)

        pop y2
        pop x2
        pop y1
        pop x1
        mov x1,0
        mov x2,0
        mov y1,0
        mov y2,0
.else

        pop y2
        pop x2
        pop y1
        pop x1

.endif
            
endm

draw_ball macro x_point, y_point, ball_color ;(x,y) center point of Ball with color

    push x_point
    push y_point

    sub x_point,1
    sub y_point,1
    
    mov bl,3

    .while(bl>0)

        push y_point
        mov bh,3
        .while(bh>0)
            
            Mov CX,x_point
            Mov DX,y_point

            Mov AL,ball_color
            Mov AH,0CH

            INT 10H

            add y_point,1
            dec bh

        .endw

        pop y_point
        add x_point,1
        dec bl

    .endw

    pop y_point
    pop x_point

endm

draw_bar macro p1, p2, p3   ;150,190,200
    
    push p1
    mov bx,p3
    mov dx,0
    .while(p1 < bx) ;10
    
        MOV CX, p1 ; 160
        MOV DL, p2 ; 190
    
        MOV AL, 14 
        MOV AH, 0CH
        int 10h
    
        ADD p1,1

    .endw
        pop p1

endm

draw_black_bar macro p1, p2, p3
    
    push p1
    mov bx,p3
    mov dx,0
    .while(p1 < bx)
    
        MOV CX, p1
        MOV DL, p2
    
        MOV AL, 0 
        MOV AH, 0CH
        int 10h
    
        ADD p1,1

    .endw
        pop p1

endm

ball_movement macro x_point, y_point, ball_dir, player_life_2, player_death_2, restarting_2; (x,y) of Ball with directions

    .if(ball_dir==1)
        
        .if(x_point>=320)
        
        mov ball_dir,2
        
        .endif
        
        .if (y_point<=0)
        
        mov ball_dir,4
    
        .endif

    .elseif(ball_dir==2)
        
        .if(y_point<=0)
        
        mov ball_dir,3

        .endif

        .if(x_point<=0)

        mov ball_dir,1

        .endif

    .elseif(ball_dir==3)

        .if(x_point<=0)

        mov ball_dir,4

        .endif

        .if(y_point>=200)

        mov ball_dir,2
        dec player_life_2
        inc player_death_2
        mov restarting_2,0
        jmp Main_page_2

        .endif

    .elseif(ball_dir==4)

        .if(x_point>=320)
        
        mov ball_dir,3

        .endif

        .if(y_point>=200)

        mov ball_dir,1
        dec player_life_2
        inc player_death_2
        mov restarting_2,0
        jmp Main_page_2

        .endif

    .endif

    push ball_dir

endm

brick_movement_2 macro x_point, y_point, life, x1, y1, x2, y2, ball_dir,check ;Position of ball and bricks with life and directions

push x_point
push y_point

mov ax,x1
mov bx,x2
mov cx,y1
mov dx,y2

.if(ball_dir==1)
        
    .if(x_point>=ax)

        .if(x_point<=bx)

            .if(y_point==dx)

                mov ball_dir,4
                dec life
                mov check,1  
                
            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==ax)

                mov ball_dir,2
                dec life
                mov check,1 

            .endif
        
        .endif
    
    .endif

.elseif(ball_dir==2)
                
    .if(x_point>=ax)

        .if(x_point<=bx)

            .if(y_point==dx)

                mov ball_dir,3
                dec life
                mov check,1 
            
            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==bx)

                mov ball_dir,1
                dec life
                mov check,1 

            .endif
        
        .endif
    
    .endif


.elseif(ball_dir==3)

    .if(x_point>=ax)

        .if(x_point<=bx)

            .if(y_point==cx)

                mov ball_dir,2
                dec life
                mov check,1 

            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==bx)

                mov ball_dir,4
                dec life
                mov check,1 
            
            .endif
        
        .endif
    
    .endif

.elseif(ball_dir==4)

    .if(x_point>=ax)

        .if(x_point<=bx)

            .if(y_point==cx)

                mov ball_dir,1
                dec life
                mov check,1 

            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==ax)

                mov ball_dir,3
                dec life
                mov check,1 

            .endif
        
        .endif
    
    .endif

.endif

    pop y_point
    pop x_point
    push check
    push ball_dir

endm

bar_movement macro x_point, y_point, BarLeftX_2, BarLRightX_2, BarY_2, ball_dir ;(x,y) of ball with directions

push x_point
push y_point
push BarLeftX_2
push BarLRightX_2

mov ax,BarLeftX_2
add ax,50
mov bx,BarLeftX_2
mov cx,0
mov cl,BarY_2

.if(ball_dir==3)
    
    .if(x_point>=bx)

        .if(x_point<=ax)

            .if(y_point==cx)

                mov ball_dir,2

            .endif
        
        .endif
    
    .endif

.elseif(ball_dir==4)
    
    .if(x_point>=bX)

        .if(x_point<=ax)

            .if(y_point==cx)

                mov ball_dir,1

            .endif
        
        .endif
    
    .endif
    
.endif

pop BarLRightX_2
pop BarLeftX_2
pop y_point
pop x_point

push ball_dir

endm

.data 

    BarLeftX_2 dw 150
    BarLRightX_2 dw 180
    BarY_2 db 190
    black_dot_2 db 0
    blue_dot_2 db 1
    white_dot_2 db 15
    red_dot_2 db 4
    ball_x_2 dw 175
    ball_y_2 dw 187
    ball_direction_2 dw 1
    player_life_2 dw 3
    player_death_2 dw 0
    life_x_2 dw 2
    life_y dw 2
    game_update_2 dw 2
    number_of_blocks_2 dw 16
    restarting_2 dw 0
    

BrickS STRUCT

    life db 3
    x1 dw 0
    y1 dw 0
    x2 dw 0
    y2 dw 0

Bricks ends

;Blocks First Line

    brick1 Bricks<2,30,20,80,30>
    brick2 Bricks<2,95,20,145,30>   
    brick3 Bricks<2,160,20,210,30>
    brick4 Bricks<2,225,20,275,30>

;Blocks Second Line

    brick5 Bricks<1,65,40,115,50>
    brick6 Bricks<1,130,40,180,50>   
    brick7 Bricks<1,195,40,245,50>

;Blocks Third Line

    brick8 Bricks<2,95,60,145,70>   
    brick9 Bricks<2,160,60,210,70>

;Blocks Fourth Line

    brick10 Bricks<1,130,80,180,90> 
    
.code 
    mov ax,@data
    mov ds,ax
    Mov ah,00h
    Mov al,13h
    Int 10h

Main_page_2:
;First Line
    draw_bricks_2 brick1.life,brick1.x1,brick1.y1,brick1.x2,brick1.y2 ;life,x1,y1,x2,y2
    draw_bricks_2 brick2.life,brick2.x1,brick2.y1,brick2.x2,brick2.y2
    draw_bricks_2 brick3.life,brick3.x1,brick3.y1,brick3.x2,brick3.y2
    draw_bricks_2 brick4.life,brick4.x1,brick4.y1,brick4.x2,brick4.y2
;Second Line
    draw_bricks_2 brick5.life,brick5.x1,brick5.y1,brick5.x2,brick5.y2
    draw_bricks_2 brick6.life,brick6.x1,brick6.y1,brick6.x2,brick6.y2
    draw_bricks_2 brick7.life,brick7.x1,brick7.y1,brick7.x2,brick7.y2
;Third Line
    draw_bricks_2 brick8.life,brick8.x1,brick8.y1,brick8.x2,brick8.y2
    draw_bricks_2 brick9.life,brick9.x1,brick9.y1,brick9.x2,brick9.y2
;Fourth Line
    draw_bricks_2 brick10.life,brick10.x1,brick10.y1,brick10.x2,brick10.y2

    draw_bar BarLeftX_2,BarY_2,BarLRightX_2 ; p1,p2,p3
    draw_ball ball_x_2,ball_y_2,white_dot_2 ; (x,y) axis of ball with white color code

    .if(player_life_2>0)

        add life_x_2,10
        draw_life life_x_2,life_y,red_dot_2 ;Players Life icons to be shown here
        sub life_x_2,10
    
    .endif

    .if(player_life_2>1)

        add life_x_2,20
        draw_life life_x_2,life_y,red_dot_2 ;Players Life icons to be shown here
        sub life_x_2,20
    
    .endif

    .if(player_life_2>2)

        add life_x_2,30
        draw_life life_x_2,life_y,red_dot_2 ;Players Life icons to be shown here
        sub life_x_2,30
    
    .endif

    .if(restarting_2==0)

    draw_black_bar BarLeftX_2,BarY_2,BarLRightX_2 ; p1,p2,p3
    draw_ball ball_x_2,ball_y_2,black_dot_2 ; (x,y) axis of ball with white color code
    mov ball_x_2,165
    mov ball_y_2,187
    mov BarLeftX_2,150
    mov BarLRightX_2,180
    mov BarY_2,190
    draw_bar BarLeftX_2,BarY_2,BarLRightX_2 ; p1,p2,p3
    draw_ball ball_x_2,ball_y_2,white_dot_2 ; (x,y) axis of ball with white color code

staring_2:
        mov ah,1
        int 16h

        jz staring_2

        mov ah,0
        int 16h

        cmp al,32
        
        je l1_2

        jmp staring_2
.endif

UpdateData_2:

    mov game_update_2,0
    dec number_of_blocks_2

;First Line
    draw_bricks_2 brick1.life,brick1.x1,brick1.y1,brick1.x2,brick1.y2 ;life,x1,y1,x2,y2
    draw_bricks_2 brick2.life,brick2.x1,brick2.y1,brick2.x2,brick2.y2
    draw_bricks_2 brick3.life,brick3.x1,brick3.y1,brick3.x2,brick3.y2
    draw_bricks_2 brick4.life,brick4.x1,brick4.y1,brick4.x2,brick4.y2
;Second Line
    draw_bricks_2 brick5.life,brick5.x1,brick5.y1,brick5.x2,brick5.y2
    draw_bricks_2 brick6.life,brick6.x1,brick6.y1,brick6.x2,brick6.y2
    draw_bricks_2 brick7.life,brick7.x1,brick7.y1,brick7.x2,brick7.y2
;Third Line
    draw_bricks_2 brick8.life,brick8.x1,brick8.y1,brick8.x2,brick8.y2
    draw_bricks_2 brick9.life,brick9.x1,brick9.y1,brick9.x2,brick9.y2
;Fourth Line
    draw_bricks_2 brick10.life,brick10.x1,brick10.y1,brick10.x2,brick10.y2

l1_2: 



    cmp game_update_2,1
    je UpdateData_2

    cmp number_of_blocks_2,0
    je exit_plz
    
    .if(player_life_2>0)

        add life_x_2,10
        draw_life life_x_2,life_y,red_dot_2 ;Players Life icons to be shown here
        sub life_x_2,10
    
    .endif

    .if(player_life_2>1)

        add life_x_2,20
        draw_life life_x_2,life_y,red_dot_2 ;Players Life icons to be shown here
        sub life_x_2,20
    
    .endif

    .if(player_life_2>2)

        add life_x_2,30
        draw_life life_x_2,life_y,red_dot_2 ;Players Life icons to be shown here
        sub life_x_2,30
    
    .endif

    .if(player_death_2==3)

        add life_x_2,10
        draw_life life_x_2,life_y,black_dot_2 ;Players Life icons to be shown here
        sub life_x_2,10
        jmp exit_plz
    
    .endif

    .if(player_death_2==2)

        add life_x_2,20
        draw_life life_x_2,life_y,black_dot_2 ;Players Life icons to be shown here
        sub life_x_2,20
    
    .endif

    .if(player_death_2==1)

        add life_x_2,30
        draw_life life_x_2,life_y,black_dot_2 ;Players Life icons to be shown here
        sub life_x_2,30
    
    .endif
    

        draw_bar BarLeftX_2,BarY_2,BarLRightX_2 ; p1,p2,p3
        draw_ball ball_x_2,ball_y_2,white_dot_2 ; (x,y) axis of ball with white color code

        mov ax,5000
        
        .while(ax>0)
        
            nop                 ;For Delay in movement of ball
            dec ax
        
        .endw

        ball_movement ball_x_2,ball_y_2,ball_direction_2,player_life_2,player_death_2,restarting_2

        pop ball_direction_2

        bar_movement ball_x_2, ball_y_2, BarLeftX_2, BarLRightX_2, BarY_2, ball_direction_2

        pop ball_direction_2

;Bricks Mechanics

;First Line
    brick_movement_2 ball_x_2,ball_y_2,brick1.life,brick1.x1,brick1.y1,brick1.x2,brick1.y2,ball_direction_2,game_update_2 ;life,x1,y1,x2,y2
    pop ball_direction_2
    pop game_update_2
    
    brick_movement_2 ball_x_2,ball_y_2,brick2.life,brick2.x1,brick2.y1,brick2.x2,brick2.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2
    
    brick_movement_2 ball_x_2,ball_y_2,brick3.life,brick3.x1,brick3.y1,brick3.x2,brick3.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2
    
    brick_movement_2 ball_x_2,ball_y_2,brick4.life,brick4.x1,brick4.y1,brick4.x2,brick4.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2

;Second Line
    brick_movement_2 ball_x_2,ball_y_2,brick5.life,brick5.x1,brick5.y1,brick5.x2,brick5.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2
    
    brick_movement_2 ball_x_2,ball_y_2,brick6.life,brick6.x1,brick6.y1,brick6.x2,brick6.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2

    brick_movement_2 ball_x_2,ball_y_2,brick7.life,brick7.x1,brick7.y1,brick7.x2,brick7.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2

;Third Line
    brick_movement_2 ball_x_2,ball_y_2,brick8.life,brick8.x1,brick8.y1,brick8.x2,brick8.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2

    brick_movement_2 ball_x_2,ball_y_2,brick9.life,brick9.x1,brick9.y1,brick9.x2,brick9.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2

;Fourth Line
    brick_movement_2 ball_x_2,ball_y_2,brick10.life,brick10.x1,brick10.y1,brick10.x2,brick10.y2,ball_direction_2,game_update_2
    pop ball_direction_2
    pop game_update_2

        mov bx,ball_direction_2

        cmp bx,1
        je dir1_2

        cmp bx,2
        je dir2_2

        cmp bx,3
        je dir3_2

        cmp bx,4
        je dir4_2


    dir1_2:

        draw_ball ball_x_2,ball_y_2,black_dot_2
        add ball_x_2,1
        sub ball_y_2,1
        draw_ball ball_x_2,ball_y_2,white_dot_2
        jmp keychecks_2
    
    dir2_2:

        draw_ball ball_x_2,ball_y_2,black_dot_2
        sub ball_x_2,1
        sub ball_y_2,1
        draw_ball ball_x_2,ball_y_2,white_dot_2
        jmp keychecks_2

    dir3_2:
            
        draw_ball ball_x_2,ball_y_2,black_dot_2
        sub ball_x_2,1
        add ball_y_2,1
        draw_ball ball_x_2,ball_y_2,white_dot_2
        jmp keychecks_2

    dir4_2:

        draw_ball ball_x_2,ball_y_2,black_dot_2
        add ball_x_2,1
        add ball_y_2,1
        draw_ball ball_x_2,ball_y_2,white_dot_2
        jmp keychecks_2

    keychecks_2:

        mov ah,1
        int 16h

        jz l1_2

        mov ah,0
        int 16h

        cmp al,112
        je game_pause_2

        cmp al,13
        je exit_plz

        mov al,ah

        cmp al,4bh
        je left_2

        cmp al,4dh
        je right_2
    
        jmp l1_2

right_2:

        cmp BarLRightX_2,320
        je l1_2
        draw_dot BarLeftX_2,BarY_2,black_dot_2
        inc BarLeftX_2
        inc BarLRightX_2
        draw_dot BarLeftX_2,BarY_2,black_dot_2
        inc BarLeftX_2
        inc BarLRightX_2
        draw_dot BarLeftX_2,BarY_2,black_dot_2
        inc BarLeftX_2
        inc BarLRightX_2
        draw_dot BarLeftX_2,BarY_2,black_dot_2
        inc BarLeftX_2
        inc BarLRightX_2
        draw_dot BarLeftX_2,BarY_2,black_dot_2
        inc BarLeftX_2
        inc BarLRightX_2

        jmp l1_2

left_2:

        cmp BarLeftX_2,0
        je l1_2
        draw_dot BarLRightX_2,BarY_2,black_dot_2
        dec BarLeftX_2
        dec BarLRightX_2
        draw_dot BarLRightX_2,BarY_2,black_dot_2
        dec BarLeftX_2
        dec BarLRightX_2
        draw_dot BarLRightX_2,BarY_2,black_dot_2
        dec BarLeftX_2
        dec BarLRightX_2
        draw_dot BarLRightX_2,BarY_2,black_dot_2
        dec BarLeftX_2
        dec BarLRightX_2
        draw_dot BarLRightX_2,BarY_2,black_dot_2
        dec BarLeftX_2
        dec BarLRightX_2
        
        jmp l1_2

game_pause_2:

        mov ah,1
        int 16h

        jz game_pause_2

        mov ah,0
        int 16h

        cmp al,112
        je l1_2

        jmp game_pause_2


exit_plz:

mov ah,4ch
int 21h
end