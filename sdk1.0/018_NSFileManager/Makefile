INFOPLIST_FILE=Info.plist
SOURCES=\
	main.m \
	MyApp.m \
	FileManager.m

CC		= /usr/local/arm-apple-darwin/bin/gcc
LD		= /opt/local/arm-apple-darwin/bin/ld
CFLAGS	= -g -O2 -Wall

LDFLAGS= -syslibroot /usr/local/arm-apple-darwin/heavenly -lobjc -ObjC \
		-framework CoreFoundation \
		-framework Foundation \
		-framework CoreGraphics \
		-framework GraphicsServices \
		-framework UIKit \
		-framework LayerKit \
		-lgcc_s_v6.1 -lm \
		/opt/local/arm-apple-darwin/csu/crt1.o \
		-lSystem

WRAPPER_NAME=$(PRODUCT_NAME).app
EXECUTABLE_NAME=$(PRODUCT_NAME)
SOURCES_ABS=$(addprefix $(SRCROOT)/,$(SOURCES))
INFOPLIST_ABS=$(addprefix $(SRCROOT)/,$(INFOPLIST_FILE))
OBJECTS=\
	$(patsubst %.c,%.o,$(filter %.c,$(SOURCES))) \
	$(patsubst %.cc,%.o,$(filter %.cc,$(SOURCES))) \
	$(patsubst %.cpp,%.o,$(filter %.cpp,$(SOURCES))) \
	$(patsubst %.m,%.o,$(filter %.m,$(SOURCES))) \
	$(patsubst %.mm,%.o,$(filter %.mm,$(SOURCES)))
OBJECTS_ABS=$(addprefix $(CONFIGURATION_TEMP_DIR)/,$(OBJECTS))
APP_ABS=$(BUILT_PRODUCTS_DIR)/$(WRAPPER_NAME)
PRODUCT_ABS=$(APP_ABS)/$(EXECUTABLE_NAME)

all: $(PRODUCT_ABS)

$(PRODUCT_ABS): $(APP_ABS) $(OBJECTS_ABS)
	$(LD) $(LDFLAGS) -o $(PRODUCT_ABS) $(OBJECTS_ABS)

$(APP_ABS): $(INFOPLIST_ABS)
	mkdir -p $(APP_ABS)
	cp $(INFOPLIST_ABS) $(APP_ABS)/
	cp $(SRCROOT)/$(RESOURCES)/*.png $(APP_ABS)/

$(CONFIGURATION_TEMP_DIR)/%.o: $(SRCROOT)/%.m
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS_ABS)
	rm -rf $(APP_ABS)

