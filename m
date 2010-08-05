Date: Thu, 5 Aug 2010 13:11:43 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
In-Reply-To: <AANLkTim_=pmLER7v=rePa=ikP2Fv0bKJkN4aafNXUTNo@mail.gmail.com>
Message-ID: <alpine.LSU.2.01.1008051303550.30611@obet.zrqbmnf.qr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
	<alpine.LSU.2.01.1008041343200.32671@obet.zrqbmnf.qr>
	<AANLkTim_=pmLER7v=rePa=ikP2Fv0bKJkN4aafNXUTNo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] ebtables PREROUTING -drop
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: ratheesh k <ratheesh.ksz@gmail.com>
Cc: Netfilter mailing list <netfilter@vger.kernel.org>, bridge@lists.linux-foundation.org

On Thursday 2010-08-05 12:42, ratheesh k wrote:
>>>
>>>What will happen,  if we drop a packet at PREROUTING chain  of ebtables ?
>>
>> Depends on the table you are referring to.
>
>What is the difference between  droppin a Pkt in Brouting chain of
>Broute table and  Drop a Pkt in  nat prerouing chain of ebtables . Or
>are they having same effect ? .

Generally, nat and broute are intended to be a configuration databases 
only, where special semantics to standard verdicts can apply, as it does 
for broute. To avoid confusion, the use of DROP in nat is not 
advised, and iptables checks for such attempts. Ebtables doesn't, but 
then again, it's the 4th-order-stepson of iptables only...
deep down below in source code, DROP just does that - drop.
