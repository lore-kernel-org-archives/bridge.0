Date: Wed, 5 Apr 2006 09:09:23 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060405090923.7e5f468e@localhost.localdomain>
In-Reply-To: <F021020DA23B6641A05E616D5EAD146373A3F9@de01exm60.ds.mot.com>
References: <F021020DA23B6641A05E616D5EAD146373A3F9@de01exm60.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Rapid Spanning Tree support
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Miller Seth-G19426 <seth.miller@motorola.com>
Cc: Bui Khanh-E12360C <E12360C@motorola.com>, bridge@osdl.org

Added bridge mailing list to RSTP discussion.

On Wed, 5 Apr 2006 11:29:42 -0400
"Miller Seth-G19426" <seth.miller@motorola.com> wrote:

>  
> That's an approach we were considering as well using
> http://sourceforge.net/projects/rstplib/. Was this what you were
> planning to start with or did you want to pull the code out of the
> kernel? We're willing to work with you getting the user space app
> working and any of the infrastructure changes as well. The plan would be
> to put all this work back into the community. We're also interested in
> adding 802.1s Multiple spanning tree.
> 
> 
> -----Original Message-----
> Actually, I would like to make RSTP (and all the spanning tree
> protocols)
> a user space utility.  There are some infrastructure changes necessary
> to propagate sufficient information to do it.

I was going to leave existing STP in kernel for now, but not enable it.
For 2.6.17, I made sure that  STP packets are received so application
can receive them (via LLC).

The next part would be adding a netlink interface to bridge module
to report and modify:
	* interface added/deleted from bridge
	* interface status change (carrier up/down)
	* interface forwarding enable/disable
	* forwarding table flush by interface.

