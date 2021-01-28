Return-Path: <roopa@nvidia.com>
References: <20210126093533.441338-1-razor@blackwall.org>
 <20210127174226.4d29f454@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <046fad19-2f44-21d2-82b9-feb1fd62b068@nvidia.com>
 <20210128105201.7c6bed82@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Roopa Prabhu <roopa@nvidia.com>
Message-ID: <2935262d-b648-e692-8e85-cd3970c2d5e1@nvidia.com>
Date: Thu, 28 Jan 2021 11:33:24 -0800
MIME-Version: 1.0
In-Reply-To: <20210128105201.7c6bed82@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611862405; bh=FrNDICoxBbzrXdCz+4jMTw7QLJt3l6WlIzcvtkAvKrY=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=ByIAo/IO3a8vr6GyBay8bS4XCmFvFSjZUE8GktaxZ6QeZigc/ZPwQnSGUxGAaK+Zy
 +kb8todrV/EJ4yc9Tq7Dqeerd/UirC9GVPvwPadsGTx7+rmuKCvvsresCNgunyWZNW
 sI4RXjLBjz3pgdlYmA8jWRyb36JnXz9BmWxGXe8qlUlFVjp4epIS7eAn027bubr+g9
 Sh3l3/LPPOy+usg9Fbn5aOH2btTJQCnmyNdFBmCO6HJQx7JP81XvetHpeEXh+Ii0/7
 erPfJuwklWRP0Ttsxc04ZAN0qC9tC7Dyi0Wj4DnqCNpi61h4NnDvPJ2ehtkqUXFckO
 xzbXH1QWnaJJg==
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: bridge: multicast:
 per-port EHT hosts limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, davem@davemloft.net


On 1/28/21 10:52 AM, Jakub Kicinski wrote:
> On Thu, 28 Jan 2021 11:12:26 +0200 Nikolay Aleksandrov wrote:
>> On 28/01/2021 03:42, Jakub Kicinski wrote:
>>> On Tue, 26 Jan 2021 11:35:31 +0200 Nikolay Aleksandrov wrote:
>>>> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>>>>
>>>> Hi,
>>>> This set adds a simple configurable per-port EHT tracked hosts limit.
>>>> Patch 01 adds a default limit of 512 tracked hosts per-port, since the EHT
>>>> changes are still only in net-next that shouldn't be a problem. Then
>>>> patch 02 adds the ability to configure and retrieve the hosts limit
>>>> and to retrieve the current number of tracked hosts per port.
>>>> Let's be on the safe side and limit the number of tracked hosts by
>>>> default while allowing the user to increase that limit if needed.
>>> Applied, thanks!
>>>
>>> I'm curious that you add those per-port sysfs files, is this a matter
>>> of policy for the bridge? Seems a bit like a waste of memory at this
>>> point.
>> Indeed, that's how historically new port and bridge options are added.
>> They're all exposed via sysfs. I wonder if we should just draw the line
>> and continue with netlink-only attributes. Perhaps we should add a comment
>> about it for anyone adding new ones.
>>
>> Since this is in net-next I can send a follow up to drop the sysfs part
>> and another to add that comment.
>>
>> WDYT?
> SGTM!

+1 :)


