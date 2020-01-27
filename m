Return-Path: <J.Lambrecht@TELEVIC.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7VvLbHC2nwsB4duJU40o5aHmVes7C5pZsBQBExB3wk=;
 b=f1gbO7pJnkZMoURVGjslF/qV31b7hyTbzT9t2ZpOkPtSjzYvwl9VD/MoU/9K1lSdJZOrfzqYE0zT7+fbEeynKILrwWjSUk5BjHMOGmP220+YFfP3t1DFby1tYhn9kX+UM7AxpRr/DL36k7UrY1ZHjX0tub2umhX1Cz7Q8aNbHVk=
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
 <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
 <20200126155911.GJ18311@lunn.ch>
 <20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net>
From: =?UTF-8?Q?J=c3=bcrgen_Lambrecht?= <j.lambrecht@televic.com>
Message-ID: <c5733ddb-a837-b866-54bf-c631baf36c54@televic.com>
Date: Mon, 27 Jan 2020 15:26:38 +0100
In-Reply-To: <20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net>
Content-Type: multipart/alternative;
 boundary="------------0A2AA567E0ABCCC585BD4A57"
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC net-next v3 06/10] net: bridge: mrp: switchdev:
 Extend switchdev API to offload MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, "Allan W. Nielsen" <allan.nielsen@microchip.com>, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

--------------0A2AA567E0ABCCC585BD4A57
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 1/27/20 12:04 PM, Allan W. Nielsen wrote:
>>> > How do you handle the 'headless chicken' scenario? User space tells
>>> > the port to start sending MRP_Test frames. It then dies. The hardware

Andrew, I am a bit confused here - maybe I missed an email-thread, I'm sorry then.

In previous emails you and others talked about hardware support to send packets (inside the switch). But somebody also talked about data-plane and control-plane (about STP in-kernel being a bad idea), and that data-plane is in-kernel, and control plane is a mrp-daemon (in user space).
And in my mind, the "hardware" you mention is a frame-injector and can be both real hardware and a driver in the kernel.

Do I see it right?

>>> > continues sending these messages, and the neighbours thinks everything
>>> > is O.K, but in reality the state machine is dead, and when the ring
>>> > breaks, the daemon is not there to fix it?
> I agree, we need to find a solution to this issue.
>


--------------0A2AA567E0ABCCC585BD4A57
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 1/27/20 12:04 PM, Allan W. Nielsen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net">
      <blockquote type="cite" style="color: #000000;">
        <blockquote type="cite" style="color: #000000;">&gt; How do you
          handle the 'headless chicken' scenario? User space tells
          <br>
          &gt; the port to start sending MRP_Test frames. It then dies.
          The hardware
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
    <p>Andrew, I am a bit confused here - maybe I missed an
      email-thread, I'm sorry then.</p>
    <p>In previous emails you and others talked about hardware support
      to send packets (inside the switch). But somebody also talked
      about data-plane and control-plane (about STP in-kernel being a
      bad idea), and that data-plane is in-kernel, and control plane is
      a mrp-daemon (in user space).<br>
      And in my mind, the &quot;hardware&quot; you mention is a frame-injector and
      can be both real hardware and a driver in the kernel.</p>
    <p>Do I see it right?<br>
    </p>
    <blockquote type="cite" cite="mid:20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net">
      <blockquote type="cite" style="color: #000000;">
        <blockquote type="cite" style="color: #000000;">&gt; continues
          sending these messages, and the neighbours thinks everything
          <br>
          &gt; is O.K, but in reality the state machine is dead, and
          when the ring
          <br>
          &gt; breaks, the daemon is not there to fix it?
          <br>
        </blockquote>
      </blockquote>
      I agree, we need to find a solution to this issue.
      <br>
      <br>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------0A2AA567E0ABCCC585BD4A57--
