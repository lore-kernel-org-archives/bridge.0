From: Rajashekhar Mansanpally <raj@roinet.com>
Content-Type: text/plain
Message-Id: <1093969608.8148.98.camel@honeycomb>
Mime-Version: 1.0
Date: Tue, 31 Aug 2004 12:26:48 -0400
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Netfilter hooks
Reply-To: raj@roinet.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

Pardon me if this a little off-topic, I don't know where else to post
this question. 
We are trying to add encryption support at layer II. Decrypting-hook on
NF_BR_LOCAL_IN and encrypting-hook at NF_BR_LOCAL_OUT. But, this is
breaking iptables pre-routing chain (Now I am not able to do
port-forwarding). Any ideas?

Thanks,
-Raj

