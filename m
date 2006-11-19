Message-ID: <915136920611190902q33930830oe414066422c3d995@mail.gmail.com>
Date: Sun, 19 Nov 2006 18:02:29 +0100
From: "=?ISO-8859-1?Q?Abel_Mart=EDn?=" <abel.martin.ruiz@gmail.com>
In-Reply-To: <49002b820611180825u628eb95cud9d52b0125a645be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
	<915136920611180514q663e65d1oec82391ed3fac700@mail.gmail.com>
	<49002b820611180825u628eb95cud9d52b0125a645be@mail.gmail.com>
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

On 11/18/06, d tbsky <tbskyd@gmail.com> wrote:
> Hi:
>     thanks for your reply. you say the bridge interface should take the ip
> address,
> not the nic. that's important. i think i go to the wrong direction. i want
> nic
> (eth0,dummy0) to have ip address, not br0. it seems not what linux bridge
> designed to do...
The problem is that a bridge device works at the link layer. A bridge
device doesn't know nothing about what is above link layer.
> by the way, i found if i set mac address manually :(eg: arp -s
> 192.168.10.254 x:x:x:x:x:x),
> then i can ping 192.168.10.254 via eth0. but i can never make dummy0 work in
> any way.
>
> Regards,
> tbsky
Could you explain what your actual purpose is? I might be misunderstanding you.
