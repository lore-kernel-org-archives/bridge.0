Date: Fri, 16 Apr 2004 14:21:01 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040416142101.52dfe6e9.davem@redhat.com>
In-Reply-To: <20040413152838.181eb743@dell_ss3.pdx.osdl.net>
References: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
	<20040413152838.181eb743@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6.5] (6/9) bridge - forwarding database
	changes
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, bridge@osdl.org

On Tue, 13 Apr 2004 15:28:38 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Make forwarding database more robust.  
>   + Don't insert invalid ether address,
>   + Report errors back so adding an interface to bridge can fail
>   + get rid of unneeded explicit pads in data structure
>   + replace bitfields with byte's for simple booleans.

Applied.
