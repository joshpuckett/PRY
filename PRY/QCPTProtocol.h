#ifndef peertalk_PTExampleProtocol_h
#define peertalk_PTExampleProtocol_h

#import <Foundation/Foundation.h>
#include <stdint.h>

static const int PTPortNumber = 2345;

enum {
  QCInfo = 100,
  PTExampleFrameTypeTextMessage = 101,
  PTExampleFrameTypePing = 102,
  PTExampleFrameTypePong = 103,
};

typedef struct _PTExampleTextFrame {
  uint32_t length;
  uint8_t utf8text[0];
} PTExampleTextFrame;



#endif
