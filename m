Date: Thu, 17 Mar 2005 09:44:10 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] max number of enslaved devices
Message-ID: <20050317094410.19446b8a@dxpl.pdx.osdl.net>
In-Reply-To: <200503171032.j2HAWqCU025245@thewayout.net>
References: <200503171032.j2HAWqCU025245@thewayout.net>
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
To: Osama Abu Elsorour <osama@wayout.net>
Cc: bridge@lists.osdl.org

On Thu, 17 Mar 2005 12:32:55 +0200
"Osama Abu Elsorour" <osama@wayout.net> wrote:

> What is the maximum number of devices that can be enslaved in a bridge
> interface?
> 
> I have tried enslaving 512 devices. Although the brctl tool did not complain
> while adding them, when I use brctl show command it only shows 255.
> 
> Thanks
> 

Depends on the kernel version.  With the 2.6 kernel and current bridge utilities,
the sysfs interface (/sys) is used and it can handle a infinite number of devices
because it walks the subdirectory /sys/class/net/br0/port to see the enslaved
devices. The older interface was limited by the response buffer size of the ioctl.
