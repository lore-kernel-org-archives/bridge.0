Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637727209;
 bh=eqz/QGVARcSmjPuurQbLH3s0ioMZvO5xAzsQ2JZIEug=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Zr1KYde+bXt/wzHlv9ghGFD1LXOxIKowsTqcoPRrqZOjRp5b2BfkscMtvb93zxxDR
 xSx36iIyk1sf2BAA6hL5b7DSbJBj3NnUuC9sznYDsWDqXWYPshnSZFvbxowfglWG4P
 445V5N5G5Lie7FN2RJk5V0j2C+7dDMWKg0oLKt0QXffYIUw/yo8xtROIXUhECkVkis
 G+pWXayrKQwGUGW9foY7vi9VBDWClh1gDcbfe1Dsts2Cl2uHd6FLvQXHlZSHPYjfg1
 2+8fBv/0efCwfOl5lvwwfe7kvSu92iqS0BMPS7lM3LWglAghmuzosXB5/1I3wgsz7B
 POZokdFnNzWSA==
Date: Tue, 23 Nov 2021 20:13:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20211123201327.3689203b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <f98615d9-a129-d0b0-e444-cb649c14d7ce@nvidia.com>
References: <20211119020642.108397-1-bernard@vivo.com>
 <YZtrM3Ukz7rKfNLN@shredder>
 <f98615d9-a129-d0b0-e444-cb649c14d7ce@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: replace simple_strtoul to kstrtol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Bernard Zhao <bernard@vivo.com>, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On Mon, 22 Nov 2021 12:17:39 +0200 Nikolay Aleksandrov wrote:
> > # ip link add name br0 type bridge vlan_filtering 1
> > # echo "0x88a8" > /sys/class/net/br0/bridge/vlan_protocol 
> > bash: echo: write error: Invalid argument
> 
> Good catch, Bernard please send a revert. Thanks.

Doesn't look like he did, would you mind taking over?
