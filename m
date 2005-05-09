Date: Mon, 9 May 2005 10:52:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] How to disable verbose kernel logs for linux ethernet
	bridge?
Message-ID: <20050509105253.293e60b9@dxpl.pdx.osdl.net>
In-Reply-To: <427D8B20.7010301@SiuLung.com>
References: <427D8B20.7010301@SiuLung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Alan Tam <Tam@SiuLung.com>
Cc: bridge@lists.osdl.org

On Sun, 08 May 2005 11:44:32 +0800
Alan Tam <Tam@SiuLung.com> wrote:

> Hi,
> 
> This is part of my dmesg output which is generated whenever some network 
> topology changes. It is very annoying. Any ways for me to inhibit those 
> which are only informational but not warnings which I need to take care? 
> I am running the all bridges on tap* interfaces emulated by OpenVPN. I 
> am running stock 2.6.8 kernel from Debian sarge.
> 
> Please CC me Thanks!
> 
>

The easiest way would be to change all those printk's you don't want to see
in the br_stp_if.c from:
	printk(KERN_INFO "%s: port ...
to
	printk(KERN_DEBUG "%s: port ...

then they will show up only in /var/log/messages.
