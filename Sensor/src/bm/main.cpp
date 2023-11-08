#include "../../include/common/definitions.h"
#include "../../include/common/datatypes.h"
#include "../../include/common/hal.h"

void setup() {
  InitHal();
}

void loop() {
  // making sure the connection is ok
  if (FirebaseUp()){
    FirebaseUpdate();
    Delay(SECONDS_1);
 }
}