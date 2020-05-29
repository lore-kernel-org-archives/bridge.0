Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590779893;
 bh=vgDSnI+7ypiz1z9yX8VrOTh1GkbhLJZZTXgp3PCi0UI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YNPdyVh2Rx2tMjeDs1WK7/snMQoVXCURWHb8cV872kD8ltBKQUnSNAxdNc1BUn/u7
 W3b2JRZ4+HCLkA+9PiVV1Fhy7VNz2Jd8vQJ94A8N/cbhPGZDeun1sjI0zEo8skGaMz
 yjzqX95r3intpixgnk5qydDy+Q1ttwO2e7UekyhY=
Date: Fri, 29 May 2020 12:18:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200529121811.583003cc@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20200529100514.920537-3-horatiu.vultur@microchip.com>
References: <20200529100514.920537-1-horatiu.vultur@microchip.com>
 <20200529100514.920537-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/2] bridge: mrp: Add support for role
	MRA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Fri, 29 May 2020 10:05:14 +0000 Horatiu Vultur wrote:
> A node that has the MRA role, it can behave as MRM or MRC.
> 
> Initially it starts as MRM and sends MRP_Test frames on both ring ports.
> If it detects that there are MRP_Test send by another MRM, then it
> checks if these frames have a lower priority than itself. In this case
> it would send MRP_Nack frames to notify the other node that it needs to
> stop sending MRP_Test frames.
> If it receives a MRP_Nack frame then it stops sending MRP_Test frames
> and starts to behave as a MRC but it would continue to monitor the
> MRP_Test frames send by MRM. If at a point the MRM stops to send
> MRP_Test frames it would get the MRM role and start to send MRP_Test
> frames.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

net/bridge/br_mrp.c:542:20: warning: cast to restricted __be16
net/bridge/br_mrp.c:542:20: warning: cast to restricted __be16
net/bridge/br_mrp.c:542:20: warning: cast to restricted __be16
net/bridge/br_mrp.c:542:20: warning: cast to restricted __be16
