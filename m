Date: Thu, 12 Feb 2004 12:05:45 -0800
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040212120545.2c61a518.davem@redhat.com>
In-Reply-To: <33981.65.172.181.23.1076454426.squirrel@www.osdl.org>
References: <33981.65.172.181.23.1076454426.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [RFC] bridge kernel API change
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Tue, 10 Feb 2004 15:07:06 -0800 (PST)
Stephen Hemminger <shemminger@osdl.org> wrote:

> Here is what I am thinking.
> 
> get version 		 - not needed?

Don't do this, it makes it tempting to use the version to make incompatible
ABI changes.

> add bridge		 - SIOCBR_ADD_BRIDGE
> del bridge		 - SIOCBR_DEL_BRIDGE
> add if		 - SIOCBR_ADD_IF
> delete if		 - SIOCBR_DEL_IF
 ...
> Other alternatives:
>  - Use just ioctl's
>  - Use just /proc (ugh) or sysctl's (double ugh)

The mix of ioctls and /sys looks fine.  I also have no strong preference for
this vs. the BSD ioctls you mentioned in a later mail.
