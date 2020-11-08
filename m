Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604793973;
 bh=O6lSemrCPL/1daHZSPh63rX8/9WvDq0mEs7nccEtOtk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ker+6/QLi3W6u+GsKg7Tu4sKydMQFZn8WqWJAnJwVTPQOB6UbXj70jUiFOtYOScPy
 o0Y7/5HTkjv+n7D1hgDv0yQZRqeBj/UfxmWeUH8go+M83ViYE2FPnDnU45oV+YiHiB
 mPTK0GXfZu4/Tz+CaVcowmANdoFls8MceCUpyqpM=
Date: Sat, 7 Nov 2020 16:06:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201107160612.2909063a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC net-next 00/28] ndo_ioctl rework
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-hams@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

On Fri,  6 Nov 2020 23:17:15 +0100 Arnd Bergmann wrote:
> Any suggestions on how to proceed? I think the ndo_siocdevprivate
> change is the most interesting here, and I would like to get
> that merged.

Splitting out / eliminating ioctl pass-thry in general seems like 
a nice clean up. How did you get the ndo_eth_ioctl patch done, was 
it manual work?

> For the wireless drivers, removing the old drivers
> instead of just the dead code might be an alternative, depending
> on whether anyone thinks there might still be users.

Dunno if you want to dig into removal with a series like this, 
anything using ioctls will be pretty old (with the exception 
of what you separated into ndo_eth_ioctl). You may get bogged 
down.
