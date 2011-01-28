MIME-Version: 1.0
In-Reply-To: <AANLkTikQtHi15t9hSck8-p-fhf3QNXfY02PwxQ_4tSNW@mail.gmail.com>
References: <AANLkTik9i930FMKv4rNajQ2v+ajkdViwFaqrUnw2hD=b@mail.gmail.com>
	<AANLkTikQtHi15t9hSck8-p-fhf3QNXfY02PwxQ_4tSNW@mail.gmail.com>
Date: Fri, 28 Jan 2011 10:39:24 +0530
Message-ID: <AANLkTimwB1pGHPQ6j6joQB0TSxpGW4P8kBSahpQ6amL1@mail.gmail.com>
From: Arun Khan <knura9@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] Packet "leakage" between two bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linux Bridge <bridge@lists.linux-foundation.org>

Ben and Jarrod thanks very much for sharing your thoughts.   I will
try Jarrod's suggestion first.

On Fri, Jan 28, 2011 at 2:02 AM, J L <lists@rrod.net> wrote:

> You have assumed (as I did, when I first tried this) that the first
> "-net nic" and "-net tap" are automatically associated with each
> other. They aren't - you have to tell KVM explicitly.

Yes, I had assumed the implicit association.

> I find it easiest to think of it as if there was a (in your example
> here) *four* port switch inside the KVM process - with two ports
> connected to the host, and two to the guests.
>
> Like a real switch, in order to run two networks through it, you need
> to VLAN it.
> Add "vlan=1" to your first pair of "-net"'s, and "vlan=2" to the other.

Although the usage of VLAN is documented in the kvm man page, this did
not strike me because my mind was set with the above assumption :)
I will give it a shot and post my results here.

Thanks again.
-- Arun Khan
