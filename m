Message-ID: <4473BBE5.3050802@osdl.org>
Date: Tue, 23 May 2006 18:50:29 -0700
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] Problem bridging frames with bridge and real interface
	MTU > 1527
References: <a9a0929d0605221737r17af6c16sd32d5f6717d274c0@mail.gmail.com>	
	<20060523110624.2984f2d5@localhost.localdomain>
	<a9a0929d0605231816u28c5515ay19b2527d60724cef@mail.gmail.com>
In-Reply-To: <a9a0929d0605231816u28c5515ay19b2527d60724cef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mark Zipp <mark.r.zipp@gmail.com>
Cc: bridge@osdl.org

Mark Zipp wrote:
> Hi Stephen,
>
> Thanks very much for getting back to me.
>
> On 24/05/06, Stephen Hemminger <shemminger@osdl.org> wrote:
>> On Tue, 23 May 2006 10:07:13 +0930
>> "Mark Zipp" <mark.r.zipp@gmail.com> wrote:
>>
>
> <snip>
>>
>> The only bridge related dropping is here in br_forward.c
>>
>> int br_dev_queue_push_xmit(struct sk_buff *skb)
>> {
>>         /* drop mtu oversized packets except tso */
>>         if (packet_length(skb) > skb->dev->mtu && 
>> !skb_shinfo(skb)->tso_size)
>>                 kfree_skb(skb);
>>
>> Are you doing VLAN's?  There was a bug not fixed until 2.6.17 that 
>> didn't
>> account for VLAN header properly.
>>
>
> No I'm not doing VLANs, just plain IP inside ethernet frames.
>
> There was a new ArchLinux kernel package available, which, going by
> its version number, corresponds to the 2.6.16.18 kernel. I've
> installed that, and been able to send 2000 byte IP pings through the
> bridge, so my problem seems to have disappeared.
>
>> Are you doing filtering?  Some netfilter module might be dropping the 
>> packets.
>>
>
> I did have some filtering enabled originally, I've just tested my 2K
> pings with and without having blanket permit lines in the incoming and
> outgoing iptables rules, and have had complete success in either case.
>
> I haven't tested it with the traffic IP/GRE traffic I originally
> encountered it with yesterday, I doubt I'll now have a problem with
> it, I'll let you know if I do.
>
> (I'll create a new email to the list to start a new thread about
> another thing that I think could be another bug in the bridge code -
> ports go through some, if not all of the STP port states even when STP
> is not running)
>
> Thanks for your help,
> Mark.
The problem (as I remember it) was often with ip_conntrack. It 
reassembles fragmented
IP packets to look at them, then didn't fragment on output.
