Date: Tue, 29 Jun 2004 08:35:10 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040629083510.37d80ec2@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040629063332.56887.qmail@web41007.mail.yahoo.com>
References: <20040629063332.56887.qmail@web41007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: modprobe: modprobe cannot locate br0 modules
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Yong Chu Eu (&#26472;&#23376;&#20305;)" <ceyong@yahoo.com>
Cc: bridge@osdl.org

On Mon, 28 Jun 2004 23:33:32 -0700 (PDT)
"Yong Chu Eu \(&#26472;&#23376;&#20305;\)" <ceyong@yahoo.com> wrote:

> Hi,
> 
> I added below code in /etc/rc.d/rc.local in order to load the bridge
> 
> brctl addbr br0
> 
> brctl addif br0 eth0
> 
> brctl addif br0 wlan0
> 
> ifconfig br0 up
> 
> but it fail, i found error in /var/log/message

Does your kernel configuration have the bridge included? That error is what
happens if you attempt to setup a bridge but the bridge hook isn't in the kernel.
