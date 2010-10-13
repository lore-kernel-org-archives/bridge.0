Date: Wed, 13 Oct 2010 08:46:39 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101013084639.5712c28c@nehalam>
In-Reply-To: <C8DB8E66.6920%mliggett@btisystems.com>
References: <C8DB8E66.6920%mliggett@btisystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] F13 bridge issues
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Mark Liggett <mliggett@btisystems.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Wed, 13 Oct 2010 11:27:18 -0400
Mark Liggett <mliggett@btisystems.com> wrote:

> Hi everyone,
> 
> I'm using Ethernet bridging on an up-to-date F13 system.  I've created a bridge adapter br0 and added eth2 and eth3 to it.  Everything works as expected for a short time before the 2 Ethernet cards used in the bridge start reporting millions of errors.  I confirmed this is the case on 2 separate systems (although both systems use Intel NICs).  To try to resolve this I've:
> 
> - Compiled and installed the latest Intel igb driver 2.3.4
> - Installed the latest Fedora kernel 2.6.34.7-56
> - Uninstalled the standard bridge-utils 1.2-9, before compiling and installing version 1.4
> 
> I've pastebin'd the system config here:  http://pastebin.ca/1960777
> 
> You can see the errors listed on eth2 and eth3.  I've tried both setting the bridge up using /etc/sysconfig/network-scripts as well as manually (using brctl and ifconfig).
> 
> My bridge/Ethernet interface configs are listed here: http://pastebin.ca/1960790
> 
> Any suggestions would be greatly appreciated.
> 
> Thanks,
> 
> Mark

You might also be creating a packet loop?
Turn on spanning tree and find out.

-- 
