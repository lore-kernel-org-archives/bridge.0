Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=b2AuOSFrOD/kMYB9UaFV2XWJXRex0zL8LTTGbRRgkcg=;
	b=xMJzNGD5msX6KBq9yi57qgpfMmuktt5ukvrjH83OyYeU5e/RlZX5qXHWYBVqLbBaZZ
	xFdqiKbCQxv2doc2NHJGvN8FTYueqiqb4fFFcErqqSe+S3EKaW2Us3wsmNSd0zIgu7+E
	mwFcmoHBIonC4CrNB0nXeZhpTLKdr6CYkoc6nFYTR0KDLuFWnsomAnm9OVumctNgqli3
	mQGTVOTO2i1EXleb9r9p+dBjF88C2IFIYWSLyzuW/Oyu+jHJ7nUOLxObe4cAvBL0+DPd
	KxnpskHNqfTKDc9VKWgFbs9eIGKor+sQ88nrzMTgoBgj0QiGxSTBv1KwA0oTO8DvznvU
	S7TA==
Date: Fri, 20 Jul 2018 14:14:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180720141422.34e83e3f@xeon-e3>
In-Reply-To: <C6B4C1AB-7991-45B3-9649-CC4A36D878A8@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-2-nikolay@cumulusnetworks.com>
	<20180720085725.6dc1743d@xeon-e3>
	<8D6C03E0-6596-4B5B-9B6C-5684B5DFE148@cumulusnetworks.com>
	<20180720102044.16b92166@xeon-e3>
	<708CD30E-1F32-4769-A1C1-FE77762FA172@cumulusnetworks.com>
	<C6B4C1AB-7991-45B3-9649-CC4A36D878A8@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
 sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On Fri, 20 Jul 2018 20:47:26 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> On July 20, 2018 8:26:36 PM GMT+03:00, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> >On July 20, 2018 8:20:44 PM GMT+03:00, Stephen Hemminger
> ><stephen@networkplumber.org> wrote:  
> >>On Fri, 20 Jul 2018 20:14:43 +0300
> >>Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> >>  
> >>> >Casting away the const on the buf variable is going to cause  
> >>warnings  
> >>> >and should not be necessary.
> >>> >    
> >>> 
> >>> It doesn't when it's casted like that, the new line is changed to  
> >>null byte so we need to drop   
> >>> the const.  
> >>
> >>Then change store function to take a char *?  
> >
> >Sure, will do.  
> 
> Acrually I can't change sysfs_ops store prototype. 
> That is the reason the bond also casts the ptr.
> 
> 
> 

Ok.
