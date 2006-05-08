Date: Mon, 8 May 2006 10:04:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Is there any possible to realize spanning tree/rapid
	spanning tree in hardware?
Message-ID: <20060508100443.5ca01dee@localhost.localdomain>
In-Reply-To: <200605071401.k47E1jXv017175@mail.bme.zju.edu.cn>
References: <200605071401.k47E1jXv017175@mail.bme.zju.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: zhangliang <liangzh@mail.bme.zju.edu.cn>
Cc: bridge@lists.osdl.org

This list is about Linux Ethernet Bridge code. Most of the embedded boxes
that do Spanning Tree do the management protocol in firmware, even if they
do the packet forwarding in hardware.

Spanning tree is a distributed algorithm so no one node has to see the whole
tree.


