Date: Tue, 15 Mar 2005 09:13:05 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050315091305.3fc07561@dxpl.pdx.osdl.net>
In-Reply-To: <20050315121930.GE3189@stusta.de>
References: <20050315121930.GE3189@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [2.6 patch] fix bridge <-> ATM compile error
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Adrian Bunk <bunk@stusta.de>
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net, bridge@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.co

Given the #ifdef mess, perhaps bridge should have the hooks available
independent of the configuration.
