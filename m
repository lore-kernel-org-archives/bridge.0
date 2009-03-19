Date: Thu, 19 Mar 2009 12:19:28 +0100
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090319111927.GD4123@psychotron.englab.brq.redhat.com>
References: <20090316111127.GB3484@psychotron.englab.brq.redhat.com>
	<20090318.232003.30974750.davem@davemloft.net>
	<20090319084444.GA4123@psychotron.englab.brq.redhat.com>
	<20090319.032143.08849045.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090319.032143.08849045.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
	work	properly in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

Thu, Mar 19, 2009 at 11:21:43AM CET, davem@davemloft.net wrote:
>From: Jiri Pirko <jpirko@redhat.com>
>Date: Thu, 19 Mar 2009 09:44:45 +0100
>
>> Yes I was looking at this thing yesterday (uc_list). But this list serves
>> to different purpose. Do you think that it will be correct to use it for this? I
>> would maybe like to make a new list similar to this for our purpose
>> (say addr_list). I think it would be more correct.
>
>Whatever you do with that list privately inside of the bonding
>driver should be fine.
Well I do not need it only inside the bonding driver. I want bridge to use this
list when adding a device in it and get mac addresses from there into its
hashlist (to recognize these addresses as local).
>
>It might upset something in the generic code if you don't clean
>it up before deregistration of the bonding device, so just be
>tidy.
