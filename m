Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwksxREnqDZhIxaP722rqDcCTZJ0GA30yPvOjRHAYo0=;
 b=g4QfpHz8xXM2mIOiHsc+z6zc3UyL1kI/y0hhLAHjklTPopP/z0XGtMeQWPyBIZleOVUh5DHlf2aDc2YJ/R7bMfmX5LQDc3Im0SgW4Hr5pINvalZe/YDthQ9QZ/KGyx3KGQvyqLaV5dA6ijc8U1v9uuDNzzGCU+0q5SbKgSQM/ehQy8wo3tCN8N7wZRfs9HcdMfay5DknhT5RJ6cn4rRfNsV9qpmrztGFHChZJGyigHqL6dIzqWtTOOvrXFl0C1tMmn7BkhUJ4/bO3BjthCDr4r8hTn6l+O6Y0MpJRP/0Km+MFlUvbMksfSmzXjAq3qVCzqiamFWHchZgGAHjQ2tiuw==
Message-ID: <9429cc71-1b0f-7fe3-c9dc-12246a397e96@nvidia.com>
Date: Tue, 15 Feb 2022 10:31:41 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220211131426.5433-1-oleksandr.mazur@plvision.eu>
 <20220214211309.261bd9d6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220214211309.261bd9d6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: multicast: notify switchdev
 driver whenever MC processing gets disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

(+CC Ido)
On 15/02/2022 07:13, Jakub Kicinski wrote:
> On Fri, 11 Feb 2022 15:14:26 +0200 Oleksandr Mazur wrote:
>> Whenever bridge driver hits the max capacity of MDBs, it disables
>> the MC processing (by setting corresponding bridge option), but never
>> notifies switchdev about such change (the notifiers are called only upon
>> explicit setting of this option, through the registered netlink interface).
>>
>> This could lead to situation when Software MDB processing gets disabled,
>> but this event never gets offloaded to the underlying Hardware.
>>
>> Fix this by adding a notify message in such case.
> 
> Any comments on this one?
> 
> We have drivers offloading mdb so presumably this should have a Fixes
> tag and go to net, right?

The change looks ok, but it'd be nice to get switchdev folks comment as well.
About the tree, -net should be targeted. I think the issue has existed
since mdb disabled could be offloaded, so the tag should be:

Fixes: 147c1e9b902c ("switchdev: bridge: Offload multicast disabled")

