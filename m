Date: Mon, 30 Oct 2006 07:28:37 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061030072837.51177183@localhost.localdomain>
In-Reply-To: <200610301527.15018.dim@openvz.org>
References: <200610301527.15018.dim@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge & it's MAC address question
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Dmitry Mishin <dim@openvz.org>
Cc: netdev@vger.kernel.org, bridge@osdl.org, devel@openvz.org

On Mon, 30 Oct 2006 15:27:14 +0300
Dmitry Mishin <dim@openvz.org> wrote:

> Hi,
> 
> Could somebody explain, why bridge uses minimal MAC of the attached devices?
> It makes this address instable, variable during bridge life-cycle, which is 
> not good for DHCP. For example, I want to attach multiple virtual devices to 
> one physical. Then, I need to make sure that after each virtual device 
> addition, bridge addr is not changed and still addr of the physical device.  
> Why not to use MAC of the first attached device?
> 

The bridge physical address is the minimum of all the attached devices.
This is done because the STP standard requires it.  You can reset it
to be the same as any of the attached devices. This will not cause a problem
unless using STP.
