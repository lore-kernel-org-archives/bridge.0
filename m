Return-Path: <teg@jklm.no>
MIME-Version: 1.0
In-Reply-To: <CAG-2HqVnWXu2dW=Su6DDxDzgg3cLSvTMu5Sf=Eq+YUv4P1d4NQ@mail.gmail.com>
References: <CAG-2HqVnWXu2dW=Su6DDxDzgg3cLSvTMu5Sf=Eq+YUv4P1d4NQ@mail.gmail.com>
From: Tom Gundersen <teg@jklm.no>
Message-ID: <CAG-2HqU2f+4i3ttLSeitwr15=cVyin9VT+UrQvKC9pMV04fW7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [BUG?] bridge_id not getting set for bridges created
	with
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 21 Apr 2014 20:56:38 -0000
To: netdev <netdev@vger.kernel.org>, bridge <bridge@lists.linux-foundation.org>
Cc: "C. R. Oldham" <cr@saltstack.com>

On Mon, Apr 21, 2014 at 9:33 PM, Tom Gundersen <teg@jklm.no> wrote:
> Hi,
>
> If IFLA_ADDRESS is set when creating a bridge over netlink, e.g.
>
> # ip link add test-bridge address b6:83:a2:b3:2f:0e type bride
>
> the bridge id is not set:
>
> # brctl show
> bridge name    bridge id        STP enabled    interfaces
> bridge1        8000.000000000000    no

My example was incomplete. To see the bug one should of course first
add an interface to the bridge:

# brctl addif bridge1 eth0


and observe that the bridge id remains unset:

# brctl show
bridge name    bridge id        STP enabled    interfaces
bridge1        8000.000000000000    no            eth0



If bridge1 had been created without specifying the mac address the
result is as expected:

# brctl show
bridge name    bridge id        STP enabled    interfaces
bridge1        8000.28d244547cdb    no            eth0

Cheers,

Tom
