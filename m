Date: Thu, 1 Apr 2004 14:13:46 -0800
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040401141346.69236947.davem@redhat.com>
In-Reply-To: <20040401135746.0f985897@dell_ss3.pdx.osdl.net>
References: <406B251B.9050907@usr.fi>
	<20040401093618.49cca9fa@dell_ss3.pdx.osdl.net>
	<406CA0D7.6020500@usr.fi>
	<20040401135746.0f985897@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] bridge (2.6.5) -- correctl handle up to 256
 ports per bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, weeti@usr.fi, bridge@osdl.org

On Thu, 1 Apr 2004 13:57:46 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> Bridge code is limited to 256 ports per bridge because the Spanning
> Tree Protocol has limit of one octet for port number.  This code
> fixes:
> 	* bogus unlock in error path when port list is full.
> 	* passes different error status for out of memory, vs
> 	  port list full.
> 	* O(n) vs O(n^2) lookup for free port number
> 	* since port and priority are both limited to one byte
> 	  don't store them as int's
> 	* makes limit explicit in code

Applied, thanks Stephen.
