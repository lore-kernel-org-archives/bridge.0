Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMkGBr0bXbLoc0r4al3bxzXWiBdclmaz3s2+8RyY/3M=;
 b=JbZsE4d9qhPR12OAkq4xoB+MCP4YAPy2Yq6rzoftX5OaMfDGwvHeDJAnUL1u/T+SlDQqhhxnxScYnhaSLmHZfQp4YQXxgyfwKI3gGpalmL2ktflE+zOOakS/W+fRNOUW61Q162H4WTl0bM7FdZHGDEfo6J483APyhVSbVhWV8GNN/eTRi92dHqNayxxaceXRe7CKoIlP3f1AcXU7gkdcDQ5qDWgzO4xt6LVQlMyo2JZqr1FjH6c5kmjLXCUkpEZYKgw3cddXcavVfhwxf6YI5xRGhgCU2fnvdVzZcM2Su8oy1qetLEXzsXZZUOt3WQibYXZ+Jm6Q5w6Tyjf8UlnCSQ==
Message-ID: <1db3aae2-2b68-a18e-2ea7-3b193612125f@nvidia.com>
Date: Wed, 24 Nov 2021 12:18:39 +0200
Content-Language: en-US
References: <20211119020642.108397-1-bernard@vivo.com>
 <YZtrM3Ukz7rKfNLN@shredder> <f98615d9-a129-d0b0-e444-cb649c14d7ce@nvidia.com>
 <20211123201327.3689203b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211123201327.3689203b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] net/bridge: replace simple_strtoul to kstrtol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Bernard Zhao <bernard@vivo.com>, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On 24/11/2021 06:13, Jakub Kicinski wrote:
> On Mon, 22 Nov 2021 12:17:39 +0200 Nikolay Aleksandrov wrote:
>>> # ip link add name br0 type bridge vlan_filtering 1
>>> # echo "0x88a8" > /sys/class/net/br0/bridge/vlan_protocol 
>>> bash: echo: write error: Invalid argument
>>
>> Good catch, Bernard please send a revert. Thanks.
> 
> Doesn't look like he did, would you mind taking over?
> 

Ido sent a patch to take care of it:
https://patchwork.kernel.org/project/netdevbpf/patch/20211124101122.3321496-1-idosch@idosch.org/

Cheers,
 Nik


