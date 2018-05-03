Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=AIhvcSe+3hgYUQ9mZn94AQB7Y1lvzZAGR9g/6sIliFY=;
	b=n1RBZjkJTjvEuNvSLBmkZjhMrY+sWFziSJeWP39/pxGWuAMiBOQ8fQu8WvUrn8mR6L6j6MXzzNpo9Uer2+rtwhp3F8NN07T3FVJANacLzj4snwqJ9y4YGgSr5yt2+ImIh7zgzuZicCUHGIfXvNJNBHB2ZI8vxY7z54sJr8fBgQI=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1525350809.git.petrm@mellanox.com>
	<33ac8ce3fcd084190c5797a409ebd7858f7d47db.1525350809.git.petrm@mellanox.com>
	<39b65224-cd35-4716-1a8c-cc1bfaff0654@cumulusnetworks.com>
Date: Thu, 03 May 2018 16:07:18 +0300
In-Reply-To: <39b65224-cd35-4716-1a8c-cc1bfaff0654@cumulusnetworks.com>
	(Nikolay Aleksandrov's message of "Thu, 3 May 2018 15:56:33 +0300")
Message-ID: <wih4ljosxa1.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 2/2] net: bridge: Notify
	about !added_by_user FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@savoirfairelinux.com, davem@davemloft.net

Nikolay Aleksandrov <nikolay@cumulusnetworks.com> writes:

> On 03/05/18 15:43, Petr Machata wrote:
>> Do not automatically bail out on sending notifications about activity on
>> non-user-added FDB entries. Instead, notify about this activity except
>> for cases where the activity itself originates in a notification, to
>> avoid sending duplicate notifications.
>>
>> Signed-off-by: Petr Machata <petrm@mellanox.com>
>> ---
>>   net/bridge/br.c           |  4 ++--
>>   net/bridge/br_fdb.c       | 47 ++++++++++++++++++++++++++---------------------
>>   net/bridge/br_private.h   |  6 ++++--
>>   net/bridge/br_switchdev.c |  2 +-
>>   4 files changed, 33 insertions(+), 26 deletions(-)
>>
>
> Thanks, looks good to me! In the future please add the reviewers to the CC list
> when sending a v2, I actually missed the v2 set and saw your reply to the cover
> letter patch later.

Sorry, I'm still tweaking my process for direct submission after going
almost exclusively through mlxsw for so long!

> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Thanks,
Petr
