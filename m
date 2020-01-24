Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G86FZTcHn/oMBBx6RFTrYjvwIujQU9r6hS03SoZfBwo=; b=M5Y0a9FlG3s9A65UDLSA37oMrU
 5OSxplA+d5tB2I9cPTXxf/H2YGVTlo57j7O0zrEwh4TO895FvN0iap+f+SzG4//k6a5/ja0C+SOCp
 bhIsBgBE/uEtql9FTUEgbedwsEv02gYoNPr/yYmt+GspdMF59mfpAmOKtLJijIPUq7tQ=;
Date: Fri, 24 Jan 2020 18:37:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200124173718.GB13647@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124161828.12206-3-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [RFC net-next v3 02/10] net: bridge: mrp: Expose
 function br_mrp_port_open
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

On Fri, Jan 24, 2020 at 05:18:20PM +0100, Horatiu Vultur wrote:
> In case the HW is capable to detect when the MRP ring is open or closed. It is
> expected that the network driver will notify the bridge that the ring is open or
> closed.
> 
> The function br_mrp_port_open is used to notify the kernel that one of the ports
> stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
> the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.

Hi Horatiu

Given the name of the function, br_mrp_port_open(), how about replacing
loc with a bool with the name open?

    Andrew
