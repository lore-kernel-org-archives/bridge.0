Date: Sat, 18 Nov 2006 09:24:53 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061118092453.61f040e2@localhost.localdomain>
In-Reply-To: <49002b820611180825u628eb95cud9d52b0125a645be@mail.gmail.com>
References: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
	<915136920611180514q663e65d1oec82391ed3fac700@mail.gmail.com>
	<49002b820611180825u628eb95cud9d52b0125a645be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge physical to several dummy interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: d tbsky <tbskyd@gmail.com>
Cc: bridge@lists.osdl.org

On Sun, 19 Nov 2006 00:25:09 +0800
"d tbsky" <tbskyd@gmail.com> wrote:

> Hi:
>     thanks for your reply. you say the bridge interface should take the ip
> address,
> not the nic. that's important. i think i go to the wrong direction. i want
> nic
> (eth0,dummy0) to have ip address, not br0. it seems not what linux bridge
> designed to do...
> by the way, i found if i set mac address manually :(eg: arp -s
> 192.168.10.254 x:x:x:x:x:x),
> then i can ping 192.168.10.254 via eth0. but i can never make dummy0 work in
> any way.
> 

You sound as if you are confused about bridging vs routing
