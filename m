From: Rajashekhar Mansanpally <raj@roinet.com>
In-Reply-To: <1084788177.21864.54.camel@igno>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	<1084472140.3354.9.camel@igno>  <1084788177.21864.54.camel@igno>
Content-Type: text/plain
Message-Id: <1085155169.15384.13.camel@honeycomb>
Mime-Version: 1.0
Date: Fri, 21 May 2004 11:59:30 -0400
Content-Transfer-Encoding: 7bit
Subject: [Bridge] locking
Reply-To: raj@roinet.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

When is the following lock needed ?

	br_write_lock_bh(BR_NETPROTO_LOCK);

-Raj

