displaystring macro linetodisplay ;Printing the string and using it through the macros
mov ah,09h
mov dx,offset linetodisplay
int 21h
endm

pushall macro
   push ax
   push bx
   push cx
   push dx
endm

popall macro
   pop dx
   pop cx
   pop bx
   pop ax
endm

screenset macro p1,p2,p3,p4,attitrubetes 
	mov ah,06h
	mov al,0h
	mov bh,attitrubetes
	mov ch,p1
	mov cl,p2
	mov dh,p3
	mov dl,p4
	int 10h
endm
onscreenpoint macro row,col
	mov ah,02
	mov bh,0h
	mov dh,row
	mov dl,col
	int 10h
endm

DisplayText Macro r,c,linetodisplay ;Printing the text which is used in the menu
  pushall 
   mov ah,2
   mov bh,0
   mov dh,r
   mov dl,c
   int 10h
   mov ah,9
   mov dx,offset linetodisplay
   int 21h
   popall
ENDM DisplayText

EmptyScreen MACRO         
    mov ax,0600h  
    mov bh,07                   
    mov cx,0      
    mov dl,80     
    mov dh,25     
    int 10h    
    
    mov ax,0
    mov ah,2
    mov dx,0
    int 10h     
ENDM EmptyScreen


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

draw_bricks macro life, x1, y1, x2, y2 ; Life/Status of the Brick, x1 y1 top left points, x2 y2 bottom right points

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

ball_movement macro x_point, y_point, ball_dir, player_life, player_death, restarting; (x,y) of Ball with directions

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
        dec player_life
        inc player_death
        mov restarting,0
        jmp Main_page

        .endif

    .elseif(ball_dir==4)

        .if(x_point>=320)
        
        mov ball_dir,3

        .endif

        .if(y_point>=200)

        mov ball_dir,1
        dec player_life
        inc player_death
        mov restarting,0
        jmp Main_page

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
                mov life,0
                mov check,1  
                
            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==ax)

                mov ball_dir,2
                mov life,0
                mov check,1 

            .endif
        
        .endif
    
    .endif

.elseif(ball_dir==2)
                
    .if(x_point>=ax)

        .if(x_point<=bx)

            .if(y_point==dx)

                mov ball_dir,3
                mov life,0
                mov check,1 
            
            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==bx)

                mov ball_dir,1
                mov life,0
                mov check,1 

            .endif
        
        .endif
    
    .endif


.elseif(ball_dir==3)

    .if(x_point>=ax)

        .if(x_point<=bx)

            .if(y_point==cx)

                mov ball_dir,2
                mov life,0
                mov check,1 

            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==bx)

                mov ball_dir,4
                mov life,0
                mov check,1 
            
            .endif
        
        .endif
    
    .endif

.elseif(ball_dir==4)

    .if(x_point>=ax)

        .if(x_point<=bx)

            .if(y_point==cx)

                mov ball_dir,1
                mov life,0
                mov check,1 

            .endif
        
        .endif
    
    .endif

    .if(y_point>=cx)

        .if(y_point<=dx)

            .if(x_point==ax)

                mov ball_dir,3
                mov life,0
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

brick_movement_3 macro x_point, y_point, life, x1, y1, x2, y2, ball_dir,check ;Position of ball and bricks with life and directions

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


bar_movement macro x_point, y_point, BarLeftX, BarRightX, BarY, ball_dir ;(x,y) of ball with directions

push x_point
push y_point
push BarLeftX
push BarRightX

mov ax,BarLeftX
add ax,50
mov bx,BarLeftX
mov cx,0
mov cl,BarY

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

pop BarRightX
pop BarLeftX
pop y_point
pop x_point

push ball_dir

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


.MODEL SMALL
.STACK 100h    
.DATA 
   
player db 50,?,50 dup('$')
string db 'Welcome to Brick Breaker Game','$'
get_name db 'Input Your Good Name: ','$'

totalscore db 'Score : 27','$'

d1 db 'Welcome to the Brick Breaker Game $'	
d2 db '=>You have to Break all the bricks.$'
d3 db '=>Break the Bricks, Bricks the break. $'
d4 db 'Press Any Key to Continue $'
;d6 db '=>Press Bar to start, <> to move . $'
d7 db 'Are you Ready? $'
ins1   db '1.Your are given three lives$'
ins2   db '2.Dont Waste Your Time$'
ins3   db '3.Press Space to start$'
ins4   db '3.1. Use  <> keys to move bar.$'
ins5   db '4.Life will be lost if ball is lost.$'
ins6   db '4.Keep breaking bricks to Win$'
ins7   db '4.Press Enter To Continue.$'
ins8   db '4.Press Esc To Quit.$'
over1  db '******Very Well Played******$'
over2  db 'Your Score is : 27$'
over3  db '************$'
str1   db 'Congratultions!!! Achievement Unlocked.$'
str2   db 'Press Enter to move to next level. $'
fhandle dw 0
	buffer dw 50 dup("$")
	fname db "file.txt",0

	var1 dw 0



    BarLeftX dw 150
    BarRightX dw 200
    BarY db 190
    black_dot db 0
    blue_dot db 1
    white_dot db 15
    red_dot db 4
    ball_x dw 175
    ball_y dw 187
    ball_direction dw 1
    player_life dw 3
    player_death dw 0
    life_x dw 2
    life_y dw 2
    game_update dw 2
    number_of_blocks dw 10
    restarting dw 0


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
    life_y_2 dw 2
    game_update_2 dw 2
    number_of_blocks_2 dw 16
    restarting_2 dw 0

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

;level1
;Blocks First Line

    b1 Bricks<3,30,20,80,30>
    b2 Bricks<4,95,20,145,30>   
    b3 Bricks<5,160,20,210,30>
    b4 Bricks<7,225,20,275,30>

;Blocks Second Line

    b5 Bricks<8,65,40,115,50>
    b6 Bricks<2,130,40,180,50>   
    b7 Bricks<9,195,40,245,50>

;Blocks Third Line

    b8 Bricks<13,95,60,145,70>   
    b9 Bricks<12,160,60,210,70>

;Blocks Fourth Line

    b10 Bricks<3,130,80,180,90> 
;level2

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

;level3
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
.CODE   
MAIN PROC  
mov ax, @DATA
mov ds, ax  
    
	EmptyScreen
	call GameStart 
	
	Mov ah,00h
    Mov al,13h
    Int 10h


	Main_page:
;First Line
   
    draw_bricks b1.life,b1.x1,b1.y1,b1.x2,b1.y2 ;life,x1,y1,x2,y2
    draw_bricks b2.life,b2.x1,b2.y1,b2.x2,b2.y2
    draw_bricks b3.life,b3.x1,b3.y1,b3.x2,b3.y2
    draw_bricks b4.life,b4.x1,b4.y1,b4.x2,b4.y2
;Second Line
    draw_bricks b5.life,b5.x1,b5.y1,b5.x2,b5.y2
    draw_bricks b6.life,b6.x1,b6.y1,b6.x2,b6.y2
    draw_bricks b7.life,b7.x1,b7.y1,b7.x2,b7.y2
;Third Line
    draw_bricks b8.life,b8.x1,b8.y1,b8.x2,b8.y2
    draw_bricks b9.life,b9.x1,b9.y1,b9.x2,b9.y2
;Fourth Line
    draw_bricks b10.life,b10.x1,b10.y1,b10.x2,b10.y2

    draw_bar BarLeftX,BarY,BarRightX ; p1,p2,p3
    draw_ball ball_x,ball_y,white_dot ; (x,y) axis of ball with white color code

     onscreenpoint 0,30
	 displaystring player
    .if(player_life>0)

        add life_x,10
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,10
    
    .endif

    .if(player_life>1)

        add life_x,20
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,20
    
    .endif

    .if(player_life>2)

        add life_x,30
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,30
    
    .endif

    .if(restarting==0)

    draw_black_bar BarLeftX,BarY,BarRightX ; p1,p2,p3
    draw_ball ball_x,ball_y,black_dot ; (x,y) axis of ball with white color code
    mov ball_x,175
    mov ball_y,187
    mov BarLeftX,150
    mov BarRightX,200
    mov BarY,190
    draw_bar BarLeftX,BarY,BarRightX ; p1,p2,p3
    draw_ball ball_x,ball_y,white_dot ; (x,y) axis of ball with white color code

staring:
        mov ah,1
        int 16h

        jz staring

        mov ah,0
        int 16h

        cmp al,32
        
        je l1

        jmp staring
.endif

UpdateData:

    mov game_update,0
    dec number_of_blocks

;First Line
    draw_bricks b1.life,b1.x1,b1.y1,b1.x2,b1.y2 ;life,x1,y1,x2,y2
    draw_bricks b2.life,b2.x1,b2.y1,b2.x2,b2.y2
    draw_bricks b3.life,b3.x1,b3.y1,b3.x2,b3.y2
    draw_bricks b4.life,b4.x1,b4.y1,b4.x2,b4.y2
;Second Line
    draw_bricks b5.life,b5.x1,b5.y1,b5.x2,b5.y2
    draw_bricks b6.life,b6.x1,b6.y1,b6.x2,b6.y2
    draw_bricks b7.life,b7.x1,b7.y1,b7.x2,b7.y2
;Third Line
    draw_bricks b8.life,b8.x1,b8.y1,b8.x2,b8.y2
    draw_bricks b9.life,b9.x1,b9.y1,b9.x2,b9.y2
;Fourth Line
    draw_bricks b10.life,b10.x1,b10.y1,b10.x2,b10.y2

l1: 



    cmp game_update,1
    je UpdateData

    cmp number_of_blocks,0
    je exit
    
    .if(player_life>0)

        add life_x,10
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,10
    
    .endif

    .if(player_life>1)

        add life_x,20
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,20
    
    .endif

    .if(player_life>2)

        add life_x,30
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,30
    
    .endif

    .if(player_death==3)

        add life_x,10
        draw_life life_x,life_y,black_dot ;Players Life icons to be shown here
        sub life_x,10
        jmp exithojao
    
    .endif

    .if(player_death==2)

        add life_x,20
        draw_life life_x,life_y,black_dot ;Players Life icons to be shown here
        sub life_x,20
    
    .endif

    .if(player_death==1)

        add life_x,30
        draw_life life_x,life_y,black_dot ;Players Life icons to be shown here
        sub life_x,30
    
    .endif
    

        draw_bar BarLeftX,BarY,BarRightX ; p1,p2,p3
        draw_ball ball_x,ball_y,white_dot ; (x,y) axis of ball with white color code

        mov ax,10000
        
        .while(ax>0)
        
            nop                 ;For Delay in movement of ball
            dec ax
        
        .endw

        ball_movement ball_x,ball_y,ball_direction,player_life,player_death,restarting

        pop ball_direction

        bar_movement ball_x, ball_y, BarLeftX, BarRightX, BarY, ball_direction

        pop ball_direction

;Bricks Mechanics

;First Line
    brick_movement ball_x,ball_y,b1.life,b1.x1,b1.y1,b1.x2,b1.y2,ball_direction,game_update ;life,x1,y1,x2,y2
    pop ball_direction
    pop game_update
    
    brick_movement ball_x,ball_y,b2.life,b2.x1,b2.y1,b2.x2,b2.y2,ball_direction,game_update
    pop ball_direction
    pop game_update
    
    brick_movement ball_x,ball_y,b3.life,b3.x1,b3.y1,b3.x2,b3.y2,ball_direction,game_update
    pop ball_direction
    pop game_update
    
    brick_movement ball_x,ball_y,b4.life,b4.x1,b4.y1,b4.x2,b4.y2,ball_direction,game_update
    pop ball_direction
    pop game_update

;Second Line
    brick_movement ball_x,ball_y,b5.life,b5.x1,b5.y1,b5.x2,b5.y2,ball_direction,game_update
    pop ball_direction
    pop game_update
    
    brick_movement ball_x,ball_y,b6.life,b6.x1,b6.y1,b6.x2,b6.y2,ball_direction,game_update
    pop ball_direction
    pop game_update

    brick_movement ball_x,ball_y,b7.life,b7.x1,b7.y1,b7.x2,b7.y2,ball_direction,game_update
    pop ball_direction
    pop game_update

;Third Line
    brick_movement ball_x,ball_y,b8.life,b8.x1,b8.y1,b8.x2,b8.y2,ball_direction,game_update
    pop ball_direction
    pop game_update

    brick_movement ball_x,ball_y,b9.life,b9.x1,b9.y1,b9.x2,b9.y2,ball_direction,game_update
    pop ball_direction
    pop game_update

;Fourth Line
    brick_movement ball_x,ball_y,b10.life,b10.x1,b10.y1,b10.x2,b10.y2,ball_direction,game_update
    pop ball_direction
    pop game_update

        mov bx,ball_direction

        cmp bx,1
        je dir1

        cmp bx,2
        je dir2

        cmp bx,3
        je dir3

        cmp bx,4
        je dir4


    dir1:

        draw_ball ball_x,ball_y,black_dot
        add ball_x,1
        sub ball_y,1
        draw_ball ball_x,ball_y,white_dot
        jmp keychecks
    
    dir2:

        draw_ball ball_x,ball_y,black_dot
        sub ball_x,1
        sub ball_y,1
        draw_ball ball_x,ball_y,white_dot
        jmp keychecks

    dir3:
            
        draw_ball ball_x,ball_y,black_dot
        sub ball_x,1
        add ball_y,1
        draw_ball ball_x,ball_y,white_dot
        jmp keychecks

    dir4:

        draw_ball ball_x,ball_y,black_dot
        add ball_x,1
        add ball_y,1
        draw_ball ball_x,ball_y,white_dot
        jmp keychecks

    keychecks:

        mov ah,1
        int 16h

        jz l1

        mov ah,0
        int 16h

        cmp al,112
        je game_pause

        cmp al,13
        je exit

        mov al,ah

        cmp al,4bh
        je left

        cmp al,4dh
        je right
    
        jmp l1

right:

        cmp BarRightX,320
        je l1
        draw_dot BarLeftX,BarY,black_dot
        inc BarLeftX
        inc BarRightX
        draw_dot BarLeftX,BarY,black_dot
        inc BarLeftX
        inc BarRightX
        draw_dot BarLeftX,BarY,black_dot
        inc BarLeftX
        inc BarRightX
        draw_dot BarLeftX,BarY,black_dot
        inc BarLeftX
        inc BarRightX
        draw_dot BarLeftX,BarY,black_dot
        inc BarLeftX
        inc BarRightX

        jmp l1

left:

        cmp BarLeftX,0
        je l1
        draw_dot BarRightX,BarY,black_dot
        dec BarLeftX
        dec BarRightX
        draw_dot BarRightX,BarY,black_dot
        dec BarLeftX
        dec BarRightX
        draw_dot BarRightX,BarY,black_dot
        dec BarLeftX
        dec BarRightX
        draw_dot BarRightX,BarY,black_dot
        dec BarLeftX
        dec BarRightX
        draw_dot BarRightX,BarY,black_dot
        dec BarLeftX
        dec BarRightX
        
        jmp l1

game_pause:

        mov ah,1
        int 16h

        jz game_pause

        mov ah,0
        int 16h

        cmp al,112
        je l1

        jmp game_pause

exit:

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
        jmp exithojao
    
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

        mov ax,7000
        
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

    Mov ah,00h
    Mov al,13h
    Int 10h

Main_page_3:
;First Line
    onscreenpoint 0,30
	displaystring player
    
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
       ; jne NextLevel
    
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
    brick_movement_3 ball_x_3,ball_y_3,brickof1.life,brickof1.x1,brickof1.y1,brickof1.x2,brickof1.y2,ball_direction_3,game_update_3 ;life,x1,y1,x2,y2
    pop ball_direction_3
    pop game_update_3
    
    brick_movement_3 ball_x_3,ball_y_3,brickof2.life,brickof2.x1,brickof2.y1,brickof2.x2,brickof2.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3
    
    brick_movement_3 ball_x_3,ball_y_3,brickof3.life,brickof3.x1,brickof3.y1,brickof3.x2,brickof3.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3
    
    brick_movement_3 ball_x_3,ball_y_3,brickof4.life,brickof4.x1,brickof4.y1,brickof4.x2,brickof4.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

;Second Line
    brick_movement_3 ball_x_3,ball_y_3,brickof5.life,brickof5.x1,brickof5.y1,brickof5.x2,brickof5.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3
    
    brick_movement_3 ball_x_3,ball_y_3,brickof6.life,brickof6.x1,brickof6.y1,brickof6.x2,brickof6.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

    brick_movement_3 ball_x_3,ball_y_3,brickof7.life,brickof7.x1,brickof7.y1,brickof7.x2,brickof7.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

;Third Line
    brick_movement_3 ball_x_3,ball_y_3,brickof8.life,brickof8.x1,brickof8.y1,brickof8.x2,brickof8.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

    brick_movement_3 ball_x_3,ball_y_3,brickof9.life,brickof9.x1,brickof9.y1,brickof9.x2,brickof9.y2,ball_direction_3,game_update_3
    pop ball_direction_3
    pop game_update_3

;Fourth Line
    brick_movement_3 ball_x_3,ball_y_3,brickof10.life,brickof10.x1,brickof10.y1,brickof10.x2,brickof10.y2,ball_direction_3,game_update_3
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


    call EndGame




Temp Proc
	push ax
	push bx
	push cx
	push dx
	push ds 

	EmptyScreen
	screenset 0,0,24,79,15h ;in order to clear the screen
	EmptyScreen

	screenset 0,0,24,79,40h ;in order to clear the screen
	screenset 7,19,15,60,0eh
	onscreenpoint 8,21
	displaystring d1
	onscreenpoint 9,21
	displaystring d2
	onscreenpoint 10,21
	displaystring d3
	onscreenpoint 11,46
	
	;onscreenpoint 12,21
	;displaystring d6
	;onscreenpoint 13,46
;	displaystring d8
	onscreenpoint 14,25
    displaystring d7
	onscreenpoint 15,25
	displaystring d4
mov ah,4CH
int 21H 
ret

Temp ENDP



GameStart Proc ;Starting the menu procedure
	push ax
	push bx
	push cx
	push dx
	push ds 

	EmptyScreen
	screenset 0,0,24,79,15h ;in order to clear the screen
	CheckNameloop:
	DisplayText 8,8,string
	DisplayText 16,16,get_name

	;Receiving the  player name from the user
	Mov ah, 3dh
	Mov al, 02h
	Mov dx, offset fname
	int 21h
	jc error1
	mov fhandle, ax
	;;;;;;;input

	mov si, offset player
	mov cx, 0

	l1:
		mov ah, 01
		int 21h

		cmp al, 13
		je outofloop

		mov [si],al

		inc si
		inc cx

	jmp l1

	outofloop:
	

	;;;;;;writing
	mov var1, cx

	Mov ah, 40h
	Mov bx, fhandle
	Mov dx, offset player
	Mov cx, var1
	int 21h
	jc error2

	;;;;;;;reading

	Mov ah, 3fh
	Mov dx, offset player
	Mov cx, lengthof player
	Mov bx, fhandle
	int 21h
	jc error3 

	error1:
		
	error2:
	error3:
	exit:

leaveloop: ;Exiting the screen after entering the name of the user
	EmptyScreen

	screenset 0,0,24,79,40h ;in order to clear the screen
	screenset 7,19,15,60,0eh
	onscreenpoint 8,21
	displaystring d1
	onscreenpoint 9,21
	displaystring d2
	onscreenpoint 10,21
	displaystring d3
	onscreenpoint 11,46
	;displaystring d5
	;onscreenpoint 12,21
	;displaystring d6
	;onscreenpoint 11,46
;	displaystring d8
	onscreenpoint 14,25
    displaystring d7
	onscreenpoint 15,25
	displaystring d4

	mov ah,01h
	int 21h

    EmptyScreen 

	screenset 0,0,24,79,50h ;in order to clear the screen
	screenset 7,19,15,60,0eh
	onscreenpoint 8,21
	displaystring ins1
	onscreenpoint 9,21
	displaystring ins2
	onscreenpoint 10,21
	displaystring ins3
	onscreenpoint 11,21
	displaystring ins4
	onscreenpoint 12,21
	displaystring ins5
	onscreenpoint 13,21
	displaystring ins6
	onscreenpoint 14,25
    displaystring ins7
	onscreenpoint 15,25
	displaystring ins8

	isinpt:
	mov AH,0            		 
	int 16H 
	cmp al,13   ;Enter to go  
	JE lessgogame
	cmp ah,1H   ;Esc to not go
	JE nogogame
	JNE isinpt
	
	nogogame:
	mov ah,4CH
	int 21H

	lessgogame: 
	pop ds
	popall

	RET
GameStart ENDP

;NextLevel Proc

 ;  mov ah,01h
;	int 21h

;	EmptyScreen
 ;   screenset 0,0,24,79,50h ;in order to clear the screen
;	screenset 7,19,15,60,0eh
;	onscreenpoint 8,21
;	displaystring str1
;	onscreenpoint 9,21
 ;   displaystring str2
;inputt:
 ;   mov AH,0            		 
;	int 16H 
;	cmp al,13  ;Check Enter
 ;   jmp Main_page_2
  ;  RET

   ; NextLevel endp


	;onscreenpoint 14,25
   ;DisplayText 8,8,str1
   ;DisplayText 10,8,str2


EndGame Proc 

    mov ah,01h
	int 21h

	EmptyScreen
    screenset 0,0,24,79,15h 
	;screenset 0,0,24,79,50h ;in order to clear the screen
	;screenset 7,19,15,60,0eh
	onscreenpoint 14,25
   DisplayText 8,8,over1
   DisplayText 10,8,over2
	;onscreenpoint 15,25
	;displaystring over2
	; onscreenpoint 11,21
	; displaystring over3
	;DisplayText 12,21,totalscore

;Exiting the program
mov ah,4CH
int 21H 
ret
EndGame ENDP 

	


main endp
end main