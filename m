Return-Path: <rasmus.villemoes@prevas.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxzfDAmNd1X5DohUgnI04lTuJPE++e2zEAcq1ZOVBKw=;
 b=c+DLeSCmMU5nRe5/hBfWC+wv4nQRRMCBT0HkRM2MMwv6ngMa/GjNjSye2ENUEP+7Pm7FTT3BEEGBSiYNLXnJaaMdRlbaidUGo9FfNpWwGW1igVXVfJNay+LrzWgEIGChsDxSqKt10guLYMpni+Ryc7ZD1M5282uN8aQjrdt9yPw=
References: <20210127205241.2864728-1-horatiu.vultur@microchip.com>
 <20210129190114.3f5b6b44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <9143d15f-c41d-f0ab-7be0-32d797820384@prevas.dk>
Date: Tue, 2 Feb 2021 08:40:02 +0100
In-Reply-To: <20210129190114.3f5b6b44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 0/4] bridge: mrp: Extend
	br_mrp_switchdev_*
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 30/01/2021 04.01, Jakub Kicinski wrote:
> On Wed, 27 Jan 2021 21:52:37 +0100 Horatiu Vultur wrote:
>> This patch series extends MRP switchdev to allow the SW to have a better
>> understanding if the HW can implement the MRP functionality or it needs
>> to help the HW to run it. There are 3 cases:

>> v2:
>>  - fix typos in comments and in commit messages
>>  - remove some of the comments
>>  - move repeated code in helper function
>>  - fix issue when deleting a node when sw_backup was true
> 
> Folks who were involved in previous MRP conversations - does this look
> good to you? Anyone planning to test?
> 

I am planning to test these, but it's unlikely I'll get around to it
this week unfortunately.

Rasmus
