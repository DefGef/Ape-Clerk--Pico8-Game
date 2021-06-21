--ape clerk--
--by geoff sejai-smith--

function _init()
    ape={x=63,y=63,sprite=1,dx=0,dy=0,f}
    ape.sprites={1,1,1,3,3,3,1,1,1,5,5,5}
    ape.timer=0
    ape.move=false
    customer={x=-20,y=96,sprite=11,f}
    convo=false
    knights={}
    create_knight(23,128,f,23,83)
    create_knight(63,221,f,13,93
    create_knight(132,0,f,132,242)
    create_knight(152,62,f,140,239)
    create_knight(152,128,f,152,241)
    create_knight(148,219,f,148,246)
    p=false --ukulele trigger--
    notes={}
    books={}
    create_book(40,264)
    book_number={}
    book_counter=(#book_number)
    camx,camy=0,0
    gameover=false
    title=true
    timer=0
    music(0)
    end
    
    function _update()
        if title then
            timer+=1
            if btn(4) and timer>30 then
                timer=0
                title=false
            end
        else
            if not gameover then
                if btn(0) then 
                    ape.f=true
                    ape.dx=-1
                    if hit(ape.x+3+ape.dx,ape.y,9,7) or hit(ape.x+3+ape.dx,ape.y+9,9,6) then
                        ape.dx=0
                    end
                    ape.x+=ape.dx
                    ape.move=true
                end
                if not btn(0) then
                    ape.move=false
                end
                if btn(1) then
                    ape.f=false
                    ape.dx=1
                    if hit(ape.x+3+ape.dx,ape.y,9,7) or hit(ape.x+3+ape.dx,ape.y+9,9,6) then
                        ape.dx=0
                    end
                    ape.x+=ape.dx
                    ape.move=true
                end
                if btn(2) then
                    ape.dy=-1
                    if hit(ape.x+3,ape.y+ape.dy,9,15) then
                        ape.dy=0
                    end
                    ape.y+=ape.dy
                    ape.move=true
                end
                if btn(3) then
                    ape.dy=1
                    if hit(ape.x+3,ape.y+ape.dy,9,15) then
                        ape.dy=0
                    end
                    ape.y+=ape.dy
                    ape.move=true
                end
                if btnp(4) then
                    p=true
                    create_note(ape.x+8,ape.y+4,ape.f)
                    sfx(0)
                elseif not btn(4) then
                    p=false
                end
            end
            
            ape.x=mid(-3,ape.x,243)
            ape.y=mid(0,ape.y,240)
            
            if ape.x>63 then
                camx=min(ape.x-63,129)
            end
            if ape.y>63 then
                camy=min(ape.y-63,129)
            end
        
            for knight in all(knights) do
                if not knight.f then
                    if knight.x<knight.bx then
                        knight.x+=1
                    elseif knight.x>=knight.bx then
                        knight.f=true
                    end
                end
        
                if knight.f then 
                    if knight.x>knight.ax then
                        knight.x-=1
                    elseif knight.x<=knight.ax then
                        knight.f=false
                    end
                end
                for note in all(notes) do
                    if knight_col(note.x,note.y,knight) then
                        del(knights,knight)
                        del(notes,note)
                        sfx(1)
                    end
                end
                if knight_col(ape.x+8,ape.y,knight) then
                    gameover=true
                    ape.move=false
                end
            end
    
        
            for note in all(notes) do
                if note.f then
                    note.x-=3
                elseif not note.f then
                    note.x+=3
                end
                if note.x>camx+128 then
                    del(notes,note)
                end
            end
        
            for book in all(books) do
                if book_col(ape.x+8,ape.y+8,book) then
                    del(books,book)
                    add(book_number, b)
                end
            end
        
            if customer.x<7 then
                customer.x+=1
                if customer.x==7 then
                    sfx(2)
                end
            end
        
            if cust_col(ape.x-3,ape.y+12,customer) then
                if book_counter==0 then
                    convo=true
                    create_book(40,244)
                elseif book_counter==1 then
                    convo=true
                    create_book(152,16)
                elseif book_counter==2 then
                    convo=true
                    create_book(240,244)
                end
            elseif btn(5) then
                convo=false
            end
            
            if gameover then
                timer+=1
                if btn(4) and timer>30 then
                    reload()
                    gameover=false
                    _init()
                end
            end 
        end
    end
    
    function _draw()
        if title then
         cls()
         camera(0,0)
         spr(160,30,16,3,1)
         spr(163,56,16,5,1)
         sspr(56,0,16,16,30,32,64,64)
         if timer>30 then
             print("press z to start",32,112,7)
      end
      rect(0,0,127,127,9)
     else
            cls()
            camera(camx,camy)
            map(0,0,0,0,32,32)
            print("welcome to",11,10,7)
            print("jerry's books",11,17,7)
            print("horror",101,56,7)
            print("sci-fi",101,91,7)
            print("fantasy",47,118,7)
            outline_ape(customer.sprite,customer.x,customer.y,customer.f)
            if ape.move then
                ape.timer+=1
                ape.sprite=ape.sprites[ape.timer%#ape.sprites+1]
            elseif not ape.move then
                ape.sprite=1
            end
            if p then
                ape.sprite=7
            end
            outline_ape(ape.sprite,ape.x,ape.y,ape.f)
        
            for knight in all(knights) do
                knight.timer+=1
                knight.sprite=knight.sprites[knight.timer%#knight.sprites+1]
                outline_knight(knight.sprite,knight.x,knight.y,knight.f)
            end
        
            for book in all(books) do
                book.sprite=book.sprites[book.timer%#book.sprites+1]
                spr(book.sprite,book.x,book.y)
            end
        
            for note in all(notes) do
                spr(16,note.x,note.y)
            end
        
            if convo and book_counter==0 then
                rectfill(camx,camy+108,camx+127,camy+127,7)
                rectfill(camx+1,camy+109,camx+126,camy+126,0)	
                print("i love fantasy books, do you",camx+2,camy+110,7)
                print("have 'warlock visage'? ❎",camx+2,camy+117,7)	
            elseif convo and book_counter==1 then
                rectfill(camx,camy+108,camx+127,camy+127,7)
                rectfill(camx+1,camy+109,camx+126,camy+126,0)	
                print("thanks!, do you have the horror",camx+2,camy+110,7)
                print("novel 'razor's banshee'? ❎",camx+2,camy+117,7)
            end
        
            print("books:"..book_counter.."/3",camx+89,camy+3,0)
            print("books:"..book_counter.."/3",camx+88,camy+2,7)
    
            if gameover then
                cls()
                rect(camx,camy,camx+127,camy+127,9)
                sspr(104,16,16,16,camx+30,camy+32,64,64)
                print("gameover",camx+44,camy+24,7)
             print("press z to restart",camx+32,camy+112,7)
            end
        end
    end
    --main code ends, additional functions below
    
    function outline_ape(sprite,x,y,f)
     for i=1,15 do
      pal(i,1)
     end
     for xoffset=-1,1 do
      for yoffset=-1,1 do
       spr(sprite,x+xoffset,y+yoffset,2,2,f)
      end
     end
     pal()
     spr(sprite,x,y,2,2,f)
    end
    
    function outline_knight(sprite,x,y,f)
     for i=1,15 do
      pal(i,1)
     end
     for xoffset=-1,1 do
      for yoffset=-1,1 do
       spr(sprite,x+xoffset,y+yoffset,2,2,f)
      end
     end
     pal()
     spr(sprite,x,y,2,2,f)
    end
    
    function create_note(x,y,f)
        note = {x=x,y=y,f=f}
        add(notes,note)
    end
    
    function hit(x,y,w,h)
        collide=false
        for i=x,x+w,w do
            if fget(mget(i/8,y/8))>0 or
                        fget(mget(i/8,(y+h)/8))>0 then
                        collide=true
            end
        end
        return collide
    end
    
    function create_knight(x,y,f,ax,bx)
        knight={x=x,y=y,f=f,ax=ax,bx=bx}
        knight.timer=0
        if knight.x<128 then
            knight.sprites={33,33,33,35,35,35}
        elseif knight.x>128 and knight.y<128 then
            knight.sprites={37,37,37,37,37,39,39,39,39,39}
        elseif knight.x>128 and knight.y>127 then
            knight.sprites={41,41,41,41,41,43,43,43,43,43}
        end
        add(knights,knight)
    end
    
    function knight_col(x,y,knight)
        if x>=knight.x and x<=knight.x+10 and y>=knight.y and y<=knight.y+15 then
            return true
        elseif x+12>=knight.x and x+12<=knight.x+10 and y+15>=knight.y and y+10<=knight.y+15 then
            return true
        end
        return false
    end
    
    function create_book(x,y)
        book={x=x,y=y}
        book.sprites={15,15,15,31,31,31}
        book.timer=0
        add(books,book)
    end
    
    function book_col(x,y,book)
        if x>=book.x and x<=book.x+8 and y>=book.y and y<=book.y+8 then
            return true
     end
        return false
    end
    
    function cust_col(x,y,customer)
        if x>=customer.x and x<=customer.x+20 and y>=customer.y-2 and y<=customer.y+8 then
            return true
     end
        return false
    end