Message-ID: <1886.91.89.6.94.1211779636.squirrel@postamt.eit.uni-kl.de>
In-Reply-To: <47BCD7FA-6D04-4D81-9F51-1A7274C05872@citylink.co.nz>
References: <2115.78.42.27.128.1211616272.squirrel@postamt.eit.uni-kl.de>
	<47BCD7FA-6D04-4D81-9F51-1A7274C05872@citylink.co.nz>
Date: Mon, 26 May 2008 07:27:16 +0200 (CEST)
From: "Faruk Keskin" <faruk@eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] How to determine where bridged packets originally come
 from ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dylan Hall <dylan@citylink.co.nz>
Cc: bridge@lists.linux-foundation.org

Thanks Dylan. I guess I have to try a similar workaround.

Bye, Faruk

> I was doing something similar with libpcap and hit the same problem.
>
> My initial fix was to query the bridge forwarding table for each
> incoming packet on the basis that the src mac will have been learnt
> and the forwarding table updated.  To keep things vaguely efficient I
> cached the forwarding table and only queried it when the src mac
> wasn't found.
>
> Later I opened multiple pcap sessions, one for each ethernet interface
> in the bridge and used a select statement to monitor them all.
>
>
> Dylan
>
>
>
> On 24/05/2008, at 8:04 PM, Faruk Keskin wrote:
>
>> Hi all,
>>
>> I ended up using raw packet sockets (ETH_P_ALL) with BPF filters
>> attached
>> (binded on the bridge interface) to capture packets for the userspace
>> host.
>>
>> Now having captured these packets from the bridge interface, how do
>> I know
>> which interface (eth0, wifi0, ..) the packets were send from
>> originally ?
>>
>> Is there a handy solution to this without modifying the packet
>> content ?
>>
>> Please help me out I you got the answer down pat.
>>
>> BR, Faruk
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
>
>


