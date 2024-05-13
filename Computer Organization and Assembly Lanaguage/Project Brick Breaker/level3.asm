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

draw_bricks macro life, x1, y1, x2, y2 ; Life/Status of the Brick, x1 y1 top left_3 points, x2 y2 bottom right_3 points

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

ball_movement macro x_point, y_point, ball_dir, player_life_3, player_death_3, restarting_3; (x,y) of Ball with directions

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
        dec player_life_3
        inc player_death_3
        mov restarting_3,0
        jmp Main_page_3

        .endif

    .elseif(ball_dir==4)

        .if(x_point>=320)
        
        mov ball_dir,3

        .endif

        .if(y_point>=200)

        mov ball_dir,1
        dec player_life_3
        inc player_death_3
        mov restarting_3,0
        jmp Main_page_3

        .endif

    .endif

    push ball_dir

endm

brick_movement macro x_point, y_point, life, x1, y1, x2, y2, ball_dir,check ;Position of ball and bricks with life and directions

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

.if(ball_dir==1)
        
    .if(x_point>=130)

        .if(x_point<=180)

            .if(y_point==50)

                mov ball_dir,4
                inc life 
                
            .endif
        
        .endif
    
    .endif

    .if(y_point>=40)

        .if(y_point<=50)

            .if(x_point==130)

                mov ball_dir,2
                inc life

            .endif
        
        .endif
    
    .endif

.elseif(ball_dir==2)
                
    .if(x_point>=130)

        .if(x_point<=180)

            .if(y_point==50)

                mov ball_dir,3
                inc life

            .endif
        
        .endif
    
    .endif

    .if(y_point>=40)

        .if(y_point<=50)

            .if(x_point==180)

                mov ball_dir,1
                inc life

            .endif
        
        .endif
    
    .endif


.elseif(ball_dir==3)

    .if(x_point>=130)

        .if(x_point<=180)

            .if(y_point==40)

                mov ball_dir,2
                inc life

            .endif
        
        .endif
    
    .endif

    .if(y_point>=40)

        .if(y_point<=50)

            .if(x_point==180)

                mov ball_dir,4
                inc life

            .endif
        
        .endif
    
    .endif

.elseif(ball_dir==4)

    .if(x_point>=130)

        .if(x_point<=180)

            .if(y_point==40)

                mov ball_dir,1 
                inc life

            .endif
        
        .endif
    
    .endif

    .if(y_point>=40)

        .if(y_point<=50)

            .if(x_point==130)

                mov ball_dir,3 
                inc life

            .endif
        
        .endif
    
    .endif

.endif

    pop y_point
    pop x_point
    push check
    push ball_dir

endm

bar_movement macro x_point, y_point, BarLeftX_3, BarRightX_3, BarY_3, ball_dir ;(x,y) of ball with directions

push x_point
push y_point
push BarLeftX_3
push BarRightX_3

mov ax,BarLeftX_3
add ax,50
mov bx,BarLeftX_3
mov cx,0
mov cl,BarY_3

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

pop BarRightX_3
pop BarLeftX_3
pop y_point
pop x_point

push ball_dir

endm

.data 

    BarLeftX_3 dw 150
    BarRightX_3 dw 180
    BarY_3 db 190
    black_dot_3 db 0
    blue_dot_3 db 1
    white_dot_3 db 15
    red_dot_3 db 4
    ball_x_3 dw 175
    ball_y_3 dw 187
    ball_direction_3 dw 1
    player_life_3 dw 3
    player_death_3 dw 0
    life_x_3 dw 2
    life_y_3 dw 2
    game_update_3 dw 2
    number_of_blocks_3 dw 50
    restarting_3 dw 0
    

BrickS STRUCT

    life db 3
    x1 dw 0
    y1 dw 0
    x2 dw 0
    y2 dw 0

Bricks ends

;Blocks First Line

    brickof1 Bricks<3,30,20,80,30>
    brickof2 Bricks<3,95,20,145,30>   
    brickof3 Bricks<3,160,20,210,30>
    brickof4 Bricks<3,225,20,275,30>

;Blocks Second Line

    brickof5 Bricks<2,65,40,115,50>
    brickof6 Bricks<7,130,40,180,50>   
    brickof7 Bricks<2,195,40,245,50>

;Blocks Third Line

    brickof8 Bricks<2,95,60,145,70>   
    brickof9 Bricks<2,160,60,210,70>

;Blocks Fourth Line

    brickof10 Bricks<3,130,80,180,90> 
    
.code 
    mov ax,@data
    mov ds,ax
    Mov ah,00h
    Mov al,13h
    Int 10h

Main_page_3:
;First Line
    draw_bricks brickof1.life,brickof1.x1,brickof1.y1,brickof1.x2,brickof1.y2 ;life,x1,y1,x2,y2
    draw_bricks brickof2.life,brickof2.x1,brickof2.y1,brickof2.x2,brickof2.y2
    draw_bricks brickof3.life,brickof3.x1,brickof3.y1,brickof3.x2,brickof3.y2
    draw_bricks brickof4.life,brickof4.x1,brickof4.y1,brickof4.x2,brickof4.y2
;Second Line
    draw_bricks brickof5.life,brickof5.x1,brickof5.y1,brickof5.x2,brickof5.y2
    draw_bricks brickof6.life,brickof6.x1,brickof6.y1,brickof6.x2,brickof6.y2
    draw_bricks brickof7.life,brickof7.x1,brickof7.y1,brickof7.x2,brickof7.y2
;Third Line
    draw_bricks brickof8.life,brickof8.x1,brickof8.y1,brickof8.x2,brickof8.y2
    draw_bricks brickof9.life,brickof9.x1,brickof9.y1,brickof9.x2,brickof9.y2
;Fourth Line
    draw_bricks brickof10.life,brickof10.x1,brickof10.y1,brickof10.x2,brickof10.y2

    draw_bar BarLeftX_3,BarY_3,BarRightX_3 ; p1,p2,p3
    draw_ball ball_x_3,ball_y_3,white_dot_3 ; (x,y) axis of ball with white color code

    .if(player_life_3>0)

        add life_x_3,10
        draw_life life_x_3,life_y_3,red_dot_3 ;Players Life icons to be shown here
        sub life_x_3,10
    
    .endif

    .if(player_life_3>1)

        add life_x_3,20
        draw_life life_x_3,life_y_3,red_dot_3 ;Players Life icons to be shown here
        sub life_x_3,20
    
    .endif

    .if(player_life_3>2)

        add life_x_3,30
        draw_life life_x_3,life_y_3,red_dot_3 ;Players Life icons to be shown here
        sub life_x_3,30
    
    .endif

    .if(restarting_3==0)

    draw_black_bar BarLeftX_3,BarY_3,BarRightX_3 ; p1,p2,p3
    draw_ball ball_x_3,ball_y_3,black_dot_3 ; (x,y) axis of ball with white color code
    mov ball_x_3,165
    mov ball_y_3,187
    mov BarLeftX_3,150
    mov BarRightX_3,180
    mov BarY_3,190
    draw_bar BarLeftX_3,BarY_3,BarRightX_3 ; p1,p2,p3
    draw_ball ball_x_3,ball_y_3,white_dot_3 ; (x,y) axis of ball with white color code

staring_3:
        mov ah,1
        int 16h

        jz staring_3

        mov ah,0
        int 16h

        cmp al,32
        
        je l1_3

        jmp staring_3
.endif

UpdateData_3:

    mov game_update_3,0
    dec number_of_blocks_3

;First Line
    draw_bricks brickof1.life,brickof1.x1,brickof1.y1,brickof1.x2,brickof1.y2 ;life,x1,y1,x2,y2
    draw_bricks brickof2.life,brickof2.x1,brickof2.y1,brickof2.x2,brickof2.y2
    draw_bricks brickof3.life,brickof3.x1,brickof3.y1,brickof3.x2,brickof3.y2
    draw_bricks brickof4.life,brickof4.x1,brickof4.y1,brickof4.x2,brickof4.y2
;Second Line
    draw_bricks brickof5.life,brickof5.x1,brickof5.y1,brickof5.x2,brickof5.y2
    draw_bricks brickof6.life,brickof6.x1,brickof6.y1,brickof6.x2,brickof6.y2
    draw_bricks brickof7.life,brickof7.x1,brickof7.y1,brickof7.x2,brickof7.y2
;Third Line
    draw_bricks brickof8.life,brickof8.x1,brickof8.y1,brickof8.x2,brickof8.y2
    draw_bricks brickof9.life,brickof9.x1,brickof9.y1,brickof9.x2,brickof9.y2
;Fourth Line
    draw_bricks brickof10.life,brickof10.x1,brickof10.y1,brickof10.x2,brickof10.y2

l1_3: 



    cmp game_update_3,1
    je UpdateData_3

    cmp number_of_blocks_3,0
    je exithojao
    
    .if(player_life_3>0)

        add life_x_3,10
        draw_life life_x_3,life_y_3,red_dot_3 ;Players Life icons to be shown here
        sub life_x_3,10
    
    .endif

    .if(player_life_3>1)

        add life_x_3,20
        draw_life life_x_3,life_y_3,red_dot_3 ;Players Life icons to be shown here
        sub life_x_3,20
    
    .endif

    .if(player_life_3>2)

        add life_x_3,30
        draw_life life_x_3,life_y_3,red_dot_3 ;Players Life icons to be shown here
        sub life_x_3,30
    
    .endif

    .if(player_death_3==3)

        add life_x_3,10
        draw_life life_x_3,life_y_3,black_dot_3 ;Players Life icons to be shown here
        sub life_x_3,10
        jmp exithojao
    
    .endif

    .if(player_death_3==2)

        add life_x_3,20
        draw_life life_x_3,life_y_3,black_dot_3 ;Players Life icons to be shown here
        sub life_x_3,20
    
    .endif

    .if(player_death_3==1)

        add life_x_3,30
        draw_life life_x_3,life_y_3,black_dot_3 ;Players Life icons to be shown here
        sub life_x_3,30
    
    .endif
    

        draw_bar BarLeftX_3,BarY_3,BarRightX_3 ; p1,p2,p3
        draw_ball ball_x_3,ball_y_3,white_dot_3 ; (x,y) axis of ball with white color code

        mov ax,5000
        
        .while(ax>0)
        
            nop                 ;For Delay in movement of ball
            dec ax
        
        .endw

        ball_movement ball_x_3,ball_y_3,ball_direction_3,player_life_3,player_death_3,restarting_3

        pop ball_direction_3

        bar_movement ball_x_3, ball_y_3, BarLeftX_3, BarRightX_3, BarY_3, ball_direction_3

        pop ball_direction_3

;Bricks Mechanics

;First Line
    brick_movement ball_x_3,ball_y_3,brickof1.life,brickof1.x1,brickof1.y1,brickof1.x2,brickof1.y2,ball_direction_3,game_update_3 ;life,x1,y1,x2,y2
    pop ball_direction_3
    pop game_update_3
    
    brick_movement ball_x_3,ball_y_3,brickof2.life,brickof2.x1,brickof2.y1,brickof2.x2,brickof2.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3
    
    brick_movement ball_x_3,ball_y_3,brickof3.life,brickof3.x1,brickof3.y1,brickof3.x2,brickof3.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3
    
    brick_movement ball_x_3,ball_y_3,brickof4.life,brickof4.x1,brickof4.y1,brickof4.x2,brickof4.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

;Second Line
    brick_movement ball_x_3,ball_y_3,brickof5.life,brickof5.x1,brickof5.y1,brickof5.x2,brickof5.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3
    
    brick_movement ball_x_3,ball_y_3,brickof6.life,brickof6.x1,brickof6.y1,brickof6.x2,brickof6.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

    brick_movement ball_x_3,ball_y_3,brickof7.life,brickof7.x1,brickof7.y1,brickof7.x2,brickof7.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

;Third Line
    brick_movement ball_x_3,ball_y_3,brickof8.life,brickof8.x1,brickof8.y1,brickof8.x2,brickof8.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

    brick_movement ball_x_3,ball_y_3,brickof9.life,brickof9.x1,brickof9.y1,brickof9.x2,brickof9.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

;Fourth Line
    brick_movement ball_x_3,ball_y_3,brickof10.life,brickof10.x1,brickof10.y1,brickof10.x2,brickof10.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

        mov bx,ball_direction_3

        cmp bx,1
        je dir1_3

        cmp bx,2
        je dir2_3

        cmp bx,3
        je dir3_3

        cmp bx,4
        je dir4_3


    dir1_3:

        draw_ball ball_x_3,ball_y_3,black_dot_3
        add ball_x_3,1
        sub ball_y_3,1
        draw_ball ball_x_3,ball_y_3,white_dot_3
        jmp keychecks_3
    
    dir2_3:

        draw_ball ball_x_3,ball_y_3,black_dot_3
        sub ball_x_3,1
        sub ball_y_3,1
        draw_ball ball_x_3,ball_y_3,white_dot_3
        jmp keychecks_3

    dir3_3:
            
        draw_ball ball_x_3,ball_y_3,black_dot_3
        sub ball_x_3,1
        add ball_y_3,1
        draw_ball ball_x_3,ball_y_3,white_dot_3
        jmp keychecks_3

    dir4_3:

        draw_ball ball_x_3,ball_y_3,black_dot_3
        add ball_x_3,1
        add ball_y_3,1
        draw_ball ball_x_3,ball_y_3,white_dot_3
        jmp keychecks_3

    keychecks_3:

        mov ah,1
        int 16h

        jz l1_3

        mov ah,0
        int 16h

        cmp al,112
        je game_pause_3

        cmp al,13
        je exithojao

        mov al,ah

        cmp al,4bh
        je left_3

        cmp al,4dh
        je right_3
    
        jmp l1_3

right_3:

        cmp BarRightX_3,320
        je l1_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3
        draw_dot BarLeftX_3,BarY_3,black_dot_3
        inc BarLeftX_3
        inc BarRightX_3

        jmp l1_3

left_3:

        cmp BarLeftX_3,0
        je l1_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        draw_dot BarRightX_3,BarY_3,black_dot_3
        dec BarLeftX_3
        dec BarRightX_3
        
        jmp l1_3

game_pause_3:

        mov ah,1
        int 16h

        jz game_pause_3

        mov ah,0
        int 16h

        cmp al,112
        je l1_3

        jmp game_pause_3


exithojao:

mov ah,4ch
int 21h
end