Date: Tue, 2 Mar 2004 00:16:28 +0100
From: =?ISO-8859-2?B?UHJ6ZW15c7NhdyBLYWJhY2nxc2tp?= <p.kabacinski@wp.pl>
Message-Id: <20040302001628.4601d21f@localhost.localdomain>
In-Reply-To: <404394AE.9050803@nortelnetworks.com>
References: <404394AE.9050803@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: i need some help with compiling bridge module
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Abhijit Kumbhare <abhijitk@nortelnetworks.com>
Cc: rubini@linux.it, bridge@lists.osdl.org

I really appreciate your help. It is working and now I can make changes only to that particular kernel module. I was looking for that information for a couple of days. 
Once again "thank you". This information is useful for anyone with desire to write ones own kernel module. I should only mention that:
7) there is some mistake; copy your kernel config (usualy /boot/config-2.X.Y-Z) to /us/src/linux-2.X.Y-Z/.config

9) remove any dependencies to other modules (which means remove any declared - in your ".config" file compiler directives (I'm not sure whether its correct in English) like in "my" bridge module:

#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
        br_fdb_get_hook = NULL;
        br_fdb_put_hook = NULL;
#endif
otherwise you will have to compile other modules;


On Mon, 01 Mar 2004 11:53:18 -0800
Abhijit Kumbhare <abhijitk@nortelnetworks.com> wrote:

> I ran into the same problem as you did - and am also a linux newbee. I modified the make 
> files from the book "Linux Device Drivers" by Alessandro Rubini to compile the bridge module
> separately in different directory from the linux source (it worked for me on linux 2.4 on a
> normal Pentium 450 MHz - I think he has taken care of most of the version dependent stuff).
> 
> You need to do the following to use that way:
> 
> 1) Create a directory somewhere - say <your_dir>
> 2) Create a sub-directory in <your_dir> called bridge (say) - so you have <your_dir>/bridge
> 3) Copy over the bridge code into <your_dir>/bridge
> 4) Copy the file Rules.make (attached) to <your_dir>
> 5) Copy the Makefile to <your_dir>/bridge
> 6) Change the variable KERNELDIR in Rules.make to your linux source path - I am using Red Hat
>    Linux so my variable was /usr/src/linux-2.4
> 7) Don't remember whether this is required for bridge module or it complained when I was compiling
>    some other module - but I had to copy my machine config to $KERNELDIR/.config (for me it was
>    the file /usr/src/linux-2.4/configs/kernel-2.4.20-i686.config).
> 8) Compile in the <your_dir>/bridge directory using make (all, clean, etc.)

....
....
