Date: Fri, 14 Apr 2006 15:17:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060414151745.062981e0@localhost.localdomain>
In-Reply-To: <20060414221312.64298.qmail@web52901.mail.yahoo.com>
References: <20060414140034.2fd7100c@localhost.localdomain>
	<20060414221312.64298.qmail@web52901.mail.yahoo.com>
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

On Fri, 14 Apr 2006 23:13:12 +0100 (BST)
Chris Rankin <rankincj@yahoo.com> wrote:

> --- Stephen Hemminger <shemminger@osdl.org> wrote:
> > Are you doing brouting or filtering? or vlan's?
> > Are the ethernet devices on the bridge doing hardware checksumming?
> > What version of kernel and configuration are running on the bridge?
> 
> The gateway is running 2.6.16.2, and all its ethernet devices are e100s. They might well do
> hardware checksumming, but the configuration used to work fine. There is no brouting / ebfilters,
> and I don't think that there's any vlan either (on the basis that I can't have it if I don't know
> what it is ;-).)
> 

If you have the patience, then "git bisect" will pin down the regression.
