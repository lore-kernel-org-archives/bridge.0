Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xlB7pdO8ZpjfH97DTU8ogLfu7UznhJEWnG5qDbqO3Iw=; b=wqBNQ7dFNb444gmlYzy+FkUH9b
 ZZSdEeka+ujTphy8GhsZX33kbGtZgKXKfJvz0vW5zqmhreezwudODlAtwfpkM9KVIyb3ouv6V71gb
 eUf9VQuYM+mkJ6Q7FZlm3+0L4lCca3v2d6C4QvaimE/wytiVshjrQTWvqFmRad3g1pHE=;
Date: Fri, 24 Jan 2020 18:43:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200124174315.GC13647@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-4-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124161828.12206-4-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [RFC net-next v3 03/10] net: bridge: mrp: Add MRP
 interface used by netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

> br_mrp_flush - will flush the FDB.

How does this differ from a normal bridge flush? I assume there is a
way for user space to flush the bridge FDB.

    Andrew
