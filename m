Date: Thu, 29 Jan 2004 13:29:48 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] brctl insmod
Message-Id: <20040129132948.58e55c19.shemminger@osdl.org>
In-Reply-To: <401971E7.5010405@nortelnetworks.com>
References: <401971E7.5010405@nortelnetworks.com>
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
To: Abhijit Kumbhare <abhijitk@nortelnetworks.com>
Cc: bridge@lists.osdl.org

On Thu, 29 Jan 2004 12:49:44 -0800
Abhijit Kumbhare <abhijitk@nortelnetworks.com> wrote:

> I noticed that when I type brctl - it does insmod when the bridge module 
> is not loaded. Where can I find the code (in the brctl or libbridge 
> code) which does that?
> 

brctl does an ioctl to get bridge info; it ends up in:
	net/socket.c


static int sock_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
		      unsigned long arg)
{
...
	switch (cmd) {
...
		case SIOCGIFBR:
		case SIOCSIFBR:
			err = -ENOPKG;
			if (!br_ioctl_hook)
				request_module("bridge");

			down(&br_ioctl_mutex);
			if (br_ioctl_hook) 
				err = br_ioctl_hook(arg);
			up(&br_ioctl_mutex);
			break;
-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
