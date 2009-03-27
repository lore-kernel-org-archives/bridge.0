Message-ID: <49CC85E9.7070903@trash.net>
Date: Fri, 27 Mar 2009 08:53:13 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>	<20090326155205.GA28868@psychotron.englab.brq.redhat.com>
	<20090327.003819.234492275.davem@davemloft.net>
In-Reply-To: <20090327.003819.234492275.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
 work properly in bridge -try4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, dada1@cosmosbay.com, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

David Miller wrote:
> From: Jiri Pirko <jpirko@redhat.com>
> Date: Thu, 26 Mar 2009 16:52:06 +0100
> 
>> (resend, updated changelog, hook moved into skb_bond_should_drop,
>> skb_bond_should_drop ifdefed)
>>
>> Hi all.
>>
>> The problem is described in following bugzilla:
>> https://bugzilla.redhat.com/show_bug.cgi?id=487763
>  ...
>> This patch solves the situation in the bonding without touching bridge code,
>> as Patrick suggested. For every incoming frame to bonding it searches the
>> destination address in slaves list and if any of slave addresses matches, it
>> rewrites the address in frame by the adress of bonding master. This ensures that
>> all frames comming thru the bonding in alb mode have the same address.
>>
>> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
> 
> 
> I don't like the hook, but if that's how it's best done....
> 
> Patrick, please review this.

Me neither, but I don't think this approach can be done without the
hook. While I still find it questionable whether this mode really
needs to be supported for a bridge at all, an alternative approach
would be to have bonding add FDB entries for all secondary MACs to
make bridging treat them as local.
