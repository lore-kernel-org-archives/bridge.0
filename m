Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZDYNRqwBExDRXRR1MBnllajpDkmWN72OefXMTvnpJxM=; b=pDIorN8GkvUAsYHcE3q9XkvtTH
 mOTju6Vz+39zitPiVfOOFlVO3gk1nnvmtxsftHXu6kBK+clKmN4Qs49LI426KGZjMaXrfkaWd0Blw
 dp9dEIcx9aDhwQIwJF/SpK5+tY3ght5DlnK+0dqsmyZbsUKcV11klQ5fU5csoI+uVJp4=;
Date: Sat, 25 Jan 2020 16:34:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200125153403.GB18311@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-5-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124161828.12206-5-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [RFC net-next v3 04/10] net: bridge: mrp: Add generic
 netlink interface to configure MRP
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

On Fri, Jan 24, 2020 at 05:18:22PM +0100, Horatiu Vultur wrote:
> Implement the generic netlink interface to configure MRP. The implementation
> will do sanity checks over the attributes and then eventually call the MRP
> interface which eventually will call the switchdev API.

Hi Horatiu

What was your thinking between adding a new generic netlink interface,
and extending the current one?

I've not looked at your user space code yet, but i assume it has to
make use of both? It needs to create the bridge and add the
interfaces. And then it needs to control the MRP state.

Allan mentioned you might get around to implementing 802.1CB? Would
that be another generic netlink interface, or would you extend the MRP
interface?

Thanks
	Andrew			
