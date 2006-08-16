Date: Wed, 16 Aug 2006 11:09:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060816110931.731d166d@localhost.localdomain>
In-Reply-To: <2fe13191741861f3e39da4d79f9b7c42@shee.org>
References: <2fe13191741861f3e39da4d79f9b7c42@shee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Dead loop on virtual device - how to interpret it ?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Moire <sec@shee.org>
Cc: "<bridge@osdl.org> <bridge@osdl.org>" <bridge@osdl.org>

On Wed, 16 Aug 2006 14:05:26 +0200
Moire <sec@shee.org> wrote:

> Dear List,
> 
> i am not so familiar with the deep art of
> network internals more with the basics one.
> Therefore i have a problem to interpret this
> error message:
> 
> Dead loop on virtual device br0, fix it urgently!
> 
> In the corresponding kernel code i found this quote:
> 
> /* It may be transient configuration error,
>     when hard_start_xmit() recurses. We detect
>     it by checking xmit owner and drop the
>     packet when deadloop is detected.
> */
> 
> but i still have no idea what could be wrong.

What are the devices you are putting in the bridge?
What kernel version?
What are the commands being used to put the devices into
the bridge.

It looks like a bridge ended up including itself some how.

> 
> My setup is an bridge (two interfaces) and local
> interface. The bridge connects the dmz with the internet.
> 
> How can i reproduce this error message - to find the cause.
> 
> What does it mean (for a not so advanced admin;).
> 
> Thanks in advance for any help.
> 
> C. Moire
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 
