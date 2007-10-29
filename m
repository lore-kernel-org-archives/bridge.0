Message-ID: <472600E6.7060203@candelatech.com>
Date: Mon, 29 Oct 2007 08:48:54 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Re: Small packets
References: <96CF49BD8B56384395D698BA99007FA32D06@exchange.pacwire.local>	<m3k5p6hxye.fsf@ursa.amorsen.dk>
	<bdfc5d6e0710290806o81321bbhcaaa7d936a50bb0c@mail.gmail.com>
In-Reply-To: <bdfc5d6e0710290806o81321bbhcaaa7d936a50bb0c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: bridge@osdl.org, Benny Amorsen <benny+usenet@amorsen.dk>

Andy Gospodarek wrote:
> On 10/29/07, Benny Amorsen <benny+usenet@amorsen.dk> wrote:
>>>>>>> "LS" == Leigh Sharpe <lsharpe@pacificwireless.com.au> writes:
>> LS> Standard e1000 hardware. The packets being bridged contain a VLAN
>> LS> tag, which is included in the 60 bytes.
>>
>> The e1000 has VLAN acceleration. The VLAN tag is sent in a separate
>> register. If you do packet capture on the sender, the packet will
>> likely look 60 bytes long, even if it is 64 bytes on the wire.
>>
>> The same thing happens on receive. Packet dumping with VLAN's is a bit
>> of a mess in Linux. If you're lucky you can find a card without VLAN
>> acceleration to do the packet dump.
>>
>>
>> /Benny
>>
> 
> Are these the lengths on the wire or when captured on the host?   The
> smallest VLAN tagged frame should be 68 bytes IIRC.  A tagged frame
> that is 64 bytes seems too small.

That is not correct per the 802.1Q VLAN RFC, though
I don't have the reference handy at the moment.

64 bytes is fine, vlan tagged or otherwise.


Thanks,
Ben



> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

