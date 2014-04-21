Return-Path: <teg@jklm.no>
MIME-Version: 1.0
From: Tom Gundersen <teg@jklm.no>
Message-ID: <CAG-2HqVnWXu2dW=Su6DDxDzgg3cLSvTMu5Sf=Eq+YUv4P1d4NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] [BUG?] bridge_id not getting set for bridges created with
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 21 Apr 2014 19:33:35 -0000
To: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: "C. R. Oldham" <cr@saltstack.com>

Hi,

If IFLA_ADDRESS is set when creating a bridge over netlink, e.g.

# ip link add test-bridge address b6:83:a2:b3:2f:0e type bride

the bridge id is not set:

# brctl show
bridge name    bridge id        STP enabled    interfaces
bridge1        8000.000000000000    no


It looks like this is caused by br_stp_set_bridge_id never beeing
called. There appear to be many ways to solve this, but not sure what
is the preferred route...

Cheers,

Tom
