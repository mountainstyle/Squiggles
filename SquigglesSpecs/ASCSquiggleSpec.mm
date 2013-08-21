#import "ASCSquiggle.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(ASCSquiggleSpec)

describe(@"ASCSquiggle", ^{
    it(@"should create a squiggle", ^{
        ASCSquiggle *squiggle = [[ASCSquiggle new] autorelease];
        expect(squiggle).to_not(be_nil);
    });
});

SPEC_END
