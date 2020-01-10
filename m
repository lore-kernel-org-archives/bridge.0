Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xl+l/Ff1h5aHS/j+yY4JLSVy0LAWP0ovd4UAXh2rwYI=;
 b=GD+hkpL7mVIsQjwBZ1pGAowSiGQaH8CrQQ0jhQbZMOA8cGm5Un+8k5Gi+5VBH2O+U+
 P6F5PMier1CZAh1PWTFbO2OsxfxV9cIwCLQgLoT+G5gDry8t5oTJdGJUqIZVvQh6sGXF
 r20ruywtum4tOg7Jkl+EDazul8zJoAJ79CIM187WMPKi67r6BE6UbPegWc78d/zHYCHm
 jFC4JxnYQDRkG0aMZ1760wa21eU1FolRndacSM/YpQyOs+o0D7K9/N6+VVqtNp9kdrsf
 ULwGP4lZwgjCMMH61AVwRvT4nbJNdQedY+4pFddeEpdcqDt79RrkdF+HPdXkC18qMus8
 iWKQ==
Date: Fri, 10 Jan 2020 07:36:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200110073609.0eddf6e3@hermes.lan>
In-Reply-To: <20200110090206.gihfd3coeilkyi23@soft-dev3.microsemi.net>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <20200109081907.06281c0f@hermes.lan>
 <20200110090206.gihfd3coeilkyi23@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC net-next Patch 0/3] net: bridge: mrp: Add support
 for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, jakub.kicinski@netronome.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com, dsahern@gmail.com, olteanv@gmail.com, davem@davemloft.net

On Fri, 10 Jan 2020 10:02:06 +0100
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> > 
> > Can this be implemented in userspace?  
> 
> The reason for putting this in kernal space is to HW offload this in
> switchdev/dsa driver. The switches which typically supports this are
> small and don't have a lot of CPU power and the bandwidth between the
> CPU and switch core is typically limited(at least this is the case with
> the switches that we are working). Therefor we need to use HW offload
> components which can inject the frames at the needed frequency and other
> components which can terminate the expected frames and just raise and
> interrupt if the test frames are not received as expected(and a few
> other HW features).
> 
> To put this in user-space we see two options:
> 1. We need to define a netlink interface which allows a user-space
> control application to ask the kernel to ask the switchdev driver to
> setup the frame-injector or frame-terminator. In theory this would be
> possible, and we have considered it, but we think that this interface
> will be too specific for our HW and will need to be changed every time
> we want to add support for a new SoC. By focusing the user-space
> interfaces on the protocol requirement, we feel more confident that we
> have an interface which we can continue to be backwards compatible with,
> and also support future/other chips with what ever facilities (if any)
> they have to HW offload.
> 
> 2. Do a UIO driver and keep protocol and driver in user-space. We do not
> really like this approach for many reasons: it pretty much prevents us from
> collaborating with the community to solve this and it will be really hard
> to have the switchdev driver controlling part of the chip and a
> user-space driver controlling other parts.
> 
> > 
> > Putting STP in the kernel was a mistake (even original author says so).
> > Adding more control protocols in kernel is a security and stability risk.  

The principal in networking is to separate control and data plane.
This is widely adopted in many areas: OVS, routing, etc.

There is an existing devlink interface for device control, it would
make sense to extend it to allow for more control of frame inject etc.
