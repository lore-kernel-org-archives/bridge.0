Message-Id: <6.2.0.14.2.20041224132024.055a6b90@mail.modemsoft.it>
Date: Fri, 24 Dec 2004 13:21:47 +0100
From: Claudio Mantegna <zerocool@lonestar.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [Bridge] Compiling Bridge Utils 1.04 
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello All,

sorry for all my error of writing...
I have tried to compile the bridge util in formality brctld and just tried 
to compile it has given me this error:

/usr/src/bridge-utils-1.0.4/brctl# make brctld

gcc -Wall -g -O2    brctld.c   -o brctld
brctld.c: In function `runchild':
brctld.c:122: warning: implicit declaration of function `br_find_bridge'
brctld.c:122: warning: assignment makes pointer from integer without a cast
brctld.c:132: warning: implicit declaration of function `br_command_lookup'
brctld.c:132: warning: assignment makes pointer from integer without a cast
brctld.c:137: error: structure has no member named `needs_bridge_argument'
brctld.c:143: warning: passing arg 1 of pointer to function from 
incompatible pointer type
brctld.c:143: error: too many arguments to function
make: *** [brctld] Error 1


How i can resolve this problem?


N.B. : I use Slackware 10 patched.....

Thanks for all...
Claudio !

