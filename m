Return-Path: <zoltan.kiss@citrix.com>
Message-ID: <530600C5.3070107@citrix.com>
Date: Thu, 20 Feb 2014 13:19:01 +0000
From: Zoltan Kiss <zoltan.kiss@citrix.com>
MIME-Version: 1.0
References: <1392433180-16052-1-git-send-email-mcgrof@do-not-panic.com>
	<1392433180-16052-2-git-send-email-mcgrof@do-not-panic.com>
	<20140216105754.63738163@nehalam.linuxnetplumber.net>
	<CAB=NE6WwbOXNLO_Mn42i7y62pEsmDOWd35B621eiJk4iaE3Hfg@mail.gmail.com>
	<1392803559.23084.99.camel@kazak.uk.xensource.com>
	<5304C13F.3030802@citrix.com>
	<CAB=NE6X6Vuo3iib0W-c5cxv0QBpnZtCC0sFyuULugQoEZAbRtg@mail.gmail.com>
In-Reply-To: <CAB=NE6X6Vuo3iib0W-c5cxv0QBpnZtCC0sFyuULugQoEZAbRtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Xen-devel] [RFC v2 1/4] bridge: enable interfaces to
 opt out from becoming the root bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Ian Campbell <Ian.Campbell@citrix.com>, kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xen-devel@lists.xenproject.org

On 19/02/14 17:02, Luis R. Rodriguez wrote:
> On Wed, Feb 19, 2014 at 6:35 AM, Zoltan Kiss <zoltan.kiss@citrix.com> wrote:
>> On 19/02/14 09:52, Ian Campbell wrote:
>>> Can't we arrange things in the Xen hotplug scripts such that if the
>>> root_block stuff isn't available/doesn't work we fallback to the
>>> existing fe:ff:ff:ff:ff usage?
>>>
>>> That would avoid concerns about forward/backwards compat I think. It
>>> wouldn't solve the issue you are targeting on old systems, but it also
>>> doesn't regress them any further.
>>
>> I agree, I think this problem could be better handled from userspace: if it
>> can set root_block then change the default MAC to a random one, if it can't,
>> then stay with the default one. Or if someone doesn't care about STP but DAD
>> is still important, userspace can have a force_random_mac option somewhere
>> to change to a random MAC regardless of root_block presence.
>
> Folks, what if I repurpose my patch to use the IFF_BRIDGE_NON_ROOT (or
> relabel to IFF_ROOT_BLOCK_DEF) flag for a default driver preference
> upon initialization so that root block will be used once the device
> gets added to a bridge. The purpose would be to avoid drivers from
> using the high MAC address hack, streamline to use a random MAC
> address thereby avoiding the possible duplicate address situation for
> IPv6. In the STP use case for these interfaces we'd just require
> userspace to unset the root block. I'd consider the STP use case the
> most odd of all. The caveat to this approach is 3.8 would be needed
> (or its the root block patches cherry picked) for base kernels older
> than 3.8.

How about this: netback sets the root_block flag and a random MAC by 
default. So the default behaviour won't change, DAD will be happy, and 
userspace don't have to do anything unless it's using netback for STP 
root bridge (I don't think there are too many toolstacks doing that), in 
which case it has to remove the root_block flag instead of setting a 
random MAC.

Zoli
