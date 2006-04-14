Date: Fri, 14 Apr 2006 14:00:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060414140034.2fd7100c@localhost.localdomain>
In-Reply-To: <20060414205815.15338.qmail@web52911.mail.yahoo.com>
References: <20060414135321.53e60516@dxpl.pdx.osdl.net>
	<20060414205815.15338.qmail@web52911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: No UDP NFS over bridges in Linux 2.6.16.x?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris Rankin <rankincj@yahoo.com>
Cc: nfs@lists.sourceforge.net, bridge@osdl.org

On Fri, 14 Apr 2006 21:58:15 +0100 (BST)
Chris Rankin <rankincj@yahoo.com> wrote:

> --- Stephen Hemminger <shemminger@osdl.org> wrote:
> > What is the mtu of eth0 and eth1 on the bridge?
> 
> 1500 on both eth0 and eth1, and on the actual bridge device too.

Are you doing brouting or filtering? or vlan's?
Are the ethernet devices on the bridge doing hardware checksumming?
What version of kernel and configuration are running on the bridge?
