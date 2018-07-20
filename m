Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=UprSfxuRMThca/N9D4qCGxKj55XI/jGkVpeFn2BLewY=;
	b=Ukg/xaDL9F+3xz4qIksISr9BVzK9LOFft05Vrk+uBhROFhD5mtSa0PDPaoGEBXSmQf
	ggW5m0f4z77oytdMoBBLRzMfV+9CrJZjN7vIkMq0cc930X+pclExTu8bPipcCF22V835
	Lt2bNBESVbzl+2uKk5lVY1EFA7yuEFjQj4W4w=
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720082222.2f8cb8d2@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <8a958ba0-be2a-ac03-57ac-10274a0de1a0@cumulusnetworks.com>
Date: Fri, 20 Jul 2018 18:26:01 +0300
MIME-Version: 1.0
In-Reply-To: <20180720082222.2f8cb8d2@xeon-e3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: add support for
	backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On 20/07/18 18:22, Stephen Hemminger wrote:
> On Fri, 20 Jul 2018 17:48:24 +0300
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> Hi,
>> This set introduces a new bridge port option that allows any port to have
>> any other port (in the same bridge of course) as its backup and traffic
>> will be forwarded to the backup port when the primary goes down. This is
>> mainly used in MLAG and EVPN setups where we have peerlink path which is
>> a backup of many (or even all) ports and is a participating bridge port
>> itself. There's more detailed information in patch 02. Patch 01 just
>> prepares the port sysfs code for options that take raw value. The main
>> issues that this set solves are scalability and fallback latency.
>>
>> We have used similar code for over 6 months now to bring the fallback
>> latency of the backup peerlink down and avoid fdb notification storms.
>> Also due to the nature of master devices such setup is currently not
>> possible, and last but not least having tens of thousands of fdbs require
>> thousands of calls to switch.
>>
>> I've also CCed our MLAG experts that have been using similar option.
>>
>> Thanks,
>>  Nik
>>
>>
>> Nikolay Aleksandrov (2):
>>   net: bridge: add support for raw sysfs port options
>>   net: bridge: add support for backup port
>>
>>  include/uapi/linux/if_link.h |  1 +
>>  net/bridge/br_forward.c      | 16 ++++++++-
>>  net/bridge/br_if.c           | 53 ++++++++++++++++++++++++++++
>>  net/bridge/br_netlink.c      | 30 +++++++++++++++-
>>  net/bridge/br_private.h      |  3 ++
>>  net/bridge/br_sysfs_if.c     | 82 ++++++++++++++++++++++++++++++++++++--------
>>  6 files changed, 168 insertions(+), 17 deletions(-)
>>
> 
> Not sure why this has to be built into the bridge.
> There already is bonding and teaming, why invent yet another?
> 

If you read the longer description in patch 02, I've explained why they
cannot solve such problem. The nature of master devices doesn't allow
such setup. We need the ports to be all primary paths with a single
backup path and also to be bridge ports.
I've stressed this point here in the short and also in the longer
description in patch 02.

We have discussed various possible alternatives but they all fall short
and can't deliver neither the switch to backup latency nor the
scalability, and their complexity is huge (multiple virtual devices with
complex forwarding rules).

We haven't taken this decision lightly.

Thanks,
 Nik
