MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.01.1008051303550.30611@obet.zrqbmnf.qr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
	<alpine.LSU.2.01.1008041343200.32671@obet.zrqbmnf.qr>
	<AANLkTim_=pmLER7v=rePa=ikP2Fv0bKJkN4aafNXUTNo@mail.gmail.com>
	<alpine.LSU.2.01.1008051303550.30611@obet.zrqbmnf.qr>
Date: Thu, 5 Aug 2010 17:09:48 +0530
Message-ID: <AANLkTi=zqyJu_TAAvK9WzGB=rLHr3B+BPWXBccwDri9e@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] ebtables PREROUTING -drop
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Netfilter mailing list <netfilter@vger.kernel.org>, bridge@lists.linux-foundation.org

On Thu, Aug 5, 2010 at 4:41 PM, Jan Engelhardt <jengelh@medozas.de> wrote:
> deep down below in source code, DROP just does that - drop.

1.  In ebtables Broute, if packet  gets  dropped , how it goes to ip
layer for further processing ?
2.  ip_route_input will be called on all frames hitting prerouting nat
table of ebtables . How it can decide where to route once it is past
prerouing hook (packet which are dropped on nat prerotuing of ebtables
) ?  /* i could be totally wrong here */


-Ratheesh


> On Thursday 2010-08-05 12:42, ratheesh k wrote:
>>>>
>>>>What will happen, =A0if we drop a packet at PREROUTING chain =A0of ebta=
bles ?
>>>
>>> Depends on the table you are referring to.
>>
>>What is the difference between =A0droppin a Pkt in Brouting chain of
>>Broute table and =A0Drop a Pkt in =A0nat prerouing chain of ebtables . Or
>>are they having same effect ? .
>
> Generally, nat and broute are intended to be a configuration databases
> only, where special semantics to standard verdicts can apply, as it does
> for broute. To avoid confusion, the use of DROP in nat is not
> advised, and iptables checks for such attempts. Ebtables doesn't, but
> then again, it's the 4th-order-stepson of iptables only...
> deep down below in source code, DROP just does that - drop.
>
