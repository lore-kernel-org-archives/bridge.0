Message-ID: <4BE387E0.1040802@redhat.com>
Date: Fri, 07 May 2010 11:24:16 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>	<1273111530.21962.2753.camel@calx>
	<20100506.004457.71584133.davem@davemloft.net>
In-Reply-To: <20100506.004457.71584133.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [v5 Patch 1/3] netpoll: add generic support for bridge
 and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: fubar@us.ibm.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, mpm@selenic.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, gospo@redhat.com, bonding-devel@lists.sourceforge.net

On 05/06/10 15:44, David Miller wrote:
> From: Matt Mackall<mpm@selenic.com>
> Date: Wed, 05 May 2010 21:05:30 -0500
>
>> On Wed, 2010-05-05 at 04:11 -0400, Amerigo Wang wrote:
>>> V5:
>>> Fix coding style problems pointed by David.
>>
>> Aside from my concern about the policy of disabling netpoll on
>> bridges/bonds with only partial netpoll support, I don't have any
>> remaining issues with this. But I'll leave it to other folks to ack the
>> underlying driver bits for this series.
>
> Yes the partial support handling is a thorny issue.
>
> But this patch set makes things better than they were before, because
> support over such devices didn't work at all previously.
>
> So I'll toss these patches into net-next-2.6, thanks everyone!

Thank you, David.

