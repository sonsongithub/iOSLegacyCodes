.SUFFIXES:.m.h

-include ../Makefile.opt

FRAMEWORKS = -framework CoreFoundation \
		-framework Foundation \
		-framework CoreGraphics \
		-framework GraphicsServices \
		-framework UIKit \
		-framework LayerKit \
		-framework CoreSurface \
		-framework OpenGLES

CFLAGS_OPT = 
LDFLAGS_OPT= 

TARGET	= OpenGLES
OBJS	= main.o MyApp.o UIGLView.o

all:$(TARGET)

$(TARGET):$(OBJS)
	$(LD) $(LDFLAGS) $(LDFLAGS_OPT) $(FRAMEWORKS) -o $@ $^
	rm -rf ./$(TARGET).app
	mkdir ./$(TARGET).app
	cp -R ./resource/* $(TARGET).app/
	mv $(TARGET) ./$(TARGET).app/

clean:
	rm -rf $(OBJS) $(TARGET) $(TARGET).app
	
.m.o:
	$(CC) -c $(CFLAGS) $(CFLAGS_OPT) $<
